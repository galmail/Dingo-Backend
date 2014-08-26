class Api::V1::PaypalController < ApplicationController
  
  # Paypal handlers
  def index
    puts params.inspect
    render :json => params.as_json
  end
  
  
end