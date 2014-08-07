class Api::V1::PaymentsController < Api::BaseController
  
  #include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging
  
  # Store User's Credit Card
  def store_credit_card
    card_params = params.permit(:type,:number,:expire_month,:expire_year,:cvv2,:first_name,:last_name)
    @credit_card = PayPal::SDK::REST::CreditCard.new(card_params)
    
    if @credit_card.create
      logger.info "CreditCard[#{@credit_card.id}] created successfully"
      current_user.update_attributes({credit_card_id: @credit_card.id})
      render :json => {success: true, credit_card_id: @credit_card.id}
    else
      logger.error "Error while creating CreditCard:"
      logger.error @credit_card.error.inspect
      render :json => {success: false, error: @credit_card.error}, status: :unprocessable_entity
    end
    
  end
  
  # Verify User's Credit Card
  def verify_credit_card
    begin
      @credit_card = PayPal::SDK::REST::CreditCard.find(current_user.credit_card_id)
      logger.info "Got CreditCard[#{@credit_card.id}]"
      render :json => {success: true, credit_card_id: @credit_card.id}
    rescue ResourceNotFound => err
      logger.error "CreditCard Not Found"
      render :json => {success: false, error: @credit_card.error}, status: :unprocessable_entity
    end
  end
  
  def authorize_payment
    params.permit(:ticket_id,:num_tickets,:offer_id)
    @credit_card = PayPal::SDK::REST::CreditCard.find(current_user.credit_card_id)
    if params.has_key?(:ticket_id)
      @ticket = Ticket.find(params[:ticket_id])
      @ticket_name = "Ticket to #{@ticket.event.name}"
      @num_tickets = params[:num_tickets]
      @price_per_ticket = @ticket.price
      @total_price = @price_per_ticket * @num_tickets
    elsif params.has_key?(:offer_id)
      offer = Offer.find(params[:offer_id])
      @ticket = offer.ticket
      @ticket_name = "Ticket to #{@ticket.event.name}"
      @num_tickets = offer.num_tickets
      @price_per_ticket = offer.price / offer.num_tickets
      @total_price = offer.price
    else
      render :json => {success: false, error: "offer_id or ticket_id is missing"}, status: :unprocessable_entity
    end
    
    # build payment
    @payment = PayPal::SDK::REST::Payment.new({
      :intent => "authorize",
      :payer => {
        :payment_method => "credit_card",
        :funding_instruments => []},
      :transactions => [{
        :item_list => {
          :items => [{
            :name => @ticket_name,
            :sku => "item",
            :price => @price_per_ticket,
            :currency => "GBP",
            :quantity => @num_tickets }]},
        :amount => {
          :total => "#{@total_price}",
          :currency => "GBP" },
        :description => @ticket_name }]})
    
    fi = PayPal::SDK::REST::FundingInstrument.new
    fi.credit_card = @credit_card
    @payment.payer.funding_instruments.push(fi)
    
    # Create Payment and return the status(true or false)
    if @payment.create
      @payment.id     # Payment Id
      #TODO save transaction
      #TODO update offer
      #TODO update available tickets
      
      render :json => {success: true, payment: @payment}
    else
      render :json => {success: false, error: @payment.error}, status: :unprocessable_entity
    end
  end
  
  
  
end