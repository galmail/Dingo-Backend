class Api::V1::StripeController < Api::BaseController
  
  def pay
    payment = params.permit(:token, :currency, :amount, :description)
    # Create the charge on Stripe's servers - this will charge the user's card
    stripe_error = nil
    begin
      charge = Stripe::Charge.create(
        :amount => params[:amount], # amount in cents, again
        :currency => params[:currency],
        :source => params[:token],
        :description => params[:description]
      )
    rescue Stripe::CardError => e
      stripe_error = e
    rescue Stripe::InvalidRequestError => e
      stripe_error = e
    rescue Stripe::AuthenticationError => e
      stripe_error = e
    rescue Stripe::APIConnectionError => e
      stripe_error = e
    rescue Stripe::StripeError => e
      stripe_error = e
    end
    
    if !stripe_error.nil?
      body = stripe_error.json_body
      err  = body[:error]
      render :json=> err, status: stripe_error.http_status
    else
      render :json=> payment.as_json, status: :ok
    end
    
  end
  
end