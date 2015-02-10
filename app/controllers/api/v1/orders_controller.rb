class Api::V1::OrdersController < Api::BaseController
  
  # Create/Make Order
  # This method is called when a buyer wishes to buy a ticket
  def create
    
    params.permit(:ticket_id,:offer_id,:promo_id,:num_tickets,:amount,:order_paid,:paypal_key)
    
    if(!params.has_key?(:ticket_id) && !params.has_key?(:offer_id))
      render :json => {success: false, error: 'please provide a ticket_id or offer_id.'}, status: :unprocessable_entity
      return false
    end
    
    current_ticket = nil
    
    if params.has_key?(:ticket_id)
      current_ticket = Ticket.find(params[:ticket_id])
    elsif params.has_key?(:offer_id)
      current_ticket = Offer.find(params[:offer_id]).ticket
    end
    
    promo_id = params[:promo_id]
    offer_id = params[:offer_id]
    num_tickets = params[:num_tickets]
    amount = params[:amount]
    
    current_order = Order.new({
      :sender_id => current_user.id,
      :receiver_id => current_ticket.user_id,
      :ticket_id => current_ticket.id,
      :event_id => current_ticket.event_id,
      :offer_id => offer_id,
      :promo_id => promo_id,
      :num_tickets => num_tickets,
      :amount => amount,
      :status => 'PENDING'
    })
    if !current_order.save
      render :json => {success: false, error: 'order has not been created correctly.'}, status: :unprocessable_entity
    else
      render :json=> current_order.as_json, status: :created
    end
    
    
    # if !params.has_key?(:order_paid)
      # @pay_response = current_order.pay
      # # Access response
      # if @pay_response.success? && @pay_response.paymentExecStatus == "CREATED"
        # current_order.paypal_key = @pay_response.payKey
        # current_order.status = "PENDING"
        # current_order.save
        # @api = PayPal::SDK::AdaptivePayments.new
        # render :json => {success: true, redirect_url: @api.payment_url(@pay_response)}
      # else
        # current_order.status = "NOT_CREATED"
        # current_order.save
        # render :json => {success: false, error: @pay_response.error}, status: :unprocessable_entity
      # end
    # else
      # current_order.paypal_key = params[:paypal_key]
      # if params[:order_paid]
        # current_order.status = "AUTHORISED"
        # current_order.save
      # else
        # current_order.status = "CANCELED"
        # current_order.save
      # end
      # render :json=> current_order.as_json, status: :created
    # end
  end
  
  # Confirm Order
  def update
    params.permit(:id)
    current_order = Order.find(params[:id])
    
    result = {}
    if params[:release]
      result = current_order.release_payment(false)
    elsif params[:refund]
      result = current_order.refund_payment
    end
    
    if result
      render :json => {success: true, order_id: current_order.id}
    else
      render :json => {success: false, error: result.error}, status: :unprocessable_entity
    end
  end
  
end