class Api::V1::StripeController < Api::BaseController
  
  def pay
    payment = params.permit(:token, :currency, :amount, :description)
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => params[:amount], # amount in cents, again
        :currency => params[:currency],
        :source => params[:token],
        :description => params[:description]
      )
      render :json=> payment.as_json, status: :ok
    rescue Stripe::CardError => e
      # The card has been declined
      render :json=> payment.as_json, status: :forbidden
    end
  end
  
end