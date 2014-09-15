class Api::V1::PaypalController < ApplicationController
  
  # Paypal handlers
  def index
    puts params.inspect
    render :json => params.as_json
  end
  
  def success
    puts "PAYPAL_SUCCESS with ORDER_ID: #{params[:order_id]}"
    render :text => "Payment Successful! Order ID: #{params[:order_id]}"
  end
  
  def cancel
    puts "PAYPAL_CANCEL with ORDER_ID: #{params[:order_id]}"
    render :text => "Payment Canceled. Order ID: #{params[:order_id]}"
  end
  
  def notification
    puts "PAYPAL_NOTIFICATION with ORDER_ID: #{params[:order_id]}"
    render :text => "Notification Received. Order ID: #{params[:order_id]}"
  end
  
end