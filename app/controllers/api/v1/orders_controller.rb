class Api::V1::OrdersController < Api::BaseController
  
  # Create/Make Order
  # This method is called when a buyer wishes to buy a ticket
  def create
    
    params.permit(:order_id,:ticket_id,:credit_card_id,:offer_id,:num_tickets,:amount)
    
    if(!params.has_key?(:order_id) && !params.has_key?(:ticket_id) && !params.has_key?(:offer_id))
      render :json => {success: false, error: 'please provide an order_id, ticket_id or offer_id.'}, status: :unprocessable_entity
      return false
    end
    
    current_ticket = nil
    
    
    if params.has_key?(:order_id)
      current_ticket = Order.find(params[:order_id]).ticket
    elsif params.has_key?(:ticket_id)
      current_ticket = Ticket.find(params[:ticket_id])
    elsif params.has_key?(:offer_id)
      current_ticket = Offer.find(params[:offer_id]).ticket
    end
    
    #credit_card_id = params[:credit_card_id]
    offer_id = params[:offer_id]
    num_tickets = params[:num_tickets]
    amount = params[:amount]
    
    # 1. Create an Order if not already created
    current_order = nil
    if params.has_key?(:order_id)
      current_order = Order.find(params[:order_id])
    else
      current_order = Order.new({
        :sender_id => current_user.id,
        :receiver_id => current_ticket.user_id,
        :ticket_id => current_ticket.id,
        #:credit_card_id => credit_card_id,
        :event_id => current_ticket.event_id,
        :offer_id => offer_id,
        :num_tickets => num_tickets,
        :amount => amount
      })
      current_order.save
    end
    
    #TODO validate order before we continue
    
    @api = PayPal::SDK::AdaptivePayments.new
    
    # Build request object
    @pay = @api.build_pay({
      :actionType => "PAY_PRIMARY",
      :feesPayer => "PRIMARYRECEIVER",
      :currencyCode => "GBP",
      :reverseAllParallelPaymentsOnError => true,
      :returnUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/success?order_id=#{current_order.id}",
      :cancelUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/cancel?order_id=#{current_order.id}",
      :ipnNotificationUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/notification?order_id=#{current_order.id}",
      :receiverList => {
        :receiver => [
          {
            :primary => true,
            :amount => current_order.amount,
            :email => Settings.DINGO_EMAIL
          },
          {
            :primary => false,
            :amount => current_order.sellers_profit,
            :email => current_order.receiver.email
          }
        ]
      }
    })
    
    # Make API call & get response
    @pay_response = @api.pay(@pay)
    
    # Access response
    if @pay_response.success? && @pay_response.paymentExecStatus == "CREATED"
      current_order.paypal_key = @pay_response.payKey
      current_order.status = "PENDING"
      current_order.save
      render :json => {success: true, redirect_url: @api.payment_url(@pay_response)}
    else
      current_order.status = "NOT_CREATED"
      current_order.save
      render :json => {success: false, error: @pay_response.error}, status: :unprocessable_entity
    end
    
  end
  
  # Confirm Order
  def update
    params.permit(:id)
    current_order = Order.find(params[:id])
    
    result = {}
    if params[:release]
      result = current_order.release_payment
    elsif params[:refund]
      result = current_order.refund_payment
    end
    
    if result.success?
      render :json => {success: true, order_id: current_order.id}
    else
      render :json => {success: false, error: result.error}, status: :unprocessable_entity
    end
  end
  
end