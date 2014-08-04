class Api::V1::PaymentsController < Api::BaseController
  
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging
  
  # Store User's Credit Card
  def store_credit_card
    card_params = params.permit(:type,:number,:expire_month,:expire_year,:cvv2,:first_name,:last_name)
    @credit_card = CreditCard.new(card_params)
    
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
      @credit_card = CreditCard.find(current_user.credit_card_id)
      logger.info "Got CreditCard[#{@credit_card.id}]"
      render :json => {success: true, credit_card_id: @credit_card.id}
    rescue ResourceNotFound => err
      logger.error "CreditCard Not Found"
      render :json => {success: false, error: @credit_card.error}, status: :unprocessable_entity
    end
  end
  
  

end