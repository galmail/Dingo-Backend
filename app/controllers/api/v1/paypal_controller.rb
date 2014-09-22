class Api::V1::PaypalController < ApplicationController
  
  # Paypal handlers
  def index
    puts params.inspect
    render :json => params.as_json
  end
  
  def success
    puts "PAYPAL_SUCCESS with ORDER_ID: #{params[:order_id]}"
    current_order = Order.find(params[:order_id])
    current_order.status = 'AUTHORISED'
    current_order.save
    
    # sending push notifications to both users (buyer and seller) 
    message_to_buyer = Message.new({
      :sender_id => current_order.receiver_id,
      :receiver_id => current_order.sender_id,
      :from_dingo => true,
      :content => 'Congrats! You have purchased a ticket. Please contact seller for collection.'
    })
    message_to_seller = Message.new({
      :sender_id => current_order.sender_id,
      :receiver_id => current_order.receiver_id,
      :from_dingo => true,
      :content => 'Congrats! You have selled a ticket. Please contact buyer for collection.'
    })
    if message_to_buyer.save and message_to_seller.save
      message_to_buyer.notify
      message_to_seller.notify
    end
    
    #TODO send emails to both buyer and seller with the order info.
    
    #TODO send email to Dingo Admin about the order.
    
    #TODO mark ticket as sold and update the ticket's event
    
    render :text => "Payment Successful! Order ID: #{params[:order_id]}"
  end
  
  def cancel
    puts "PAYPAL_CANCEL with ORDER_ID: #{params[:order_id]}"
    
    current_order = Order.find(params[:order_id])
    current_order.status = 'CANCELED'
    current_order.save
    
    render :text => "Payment Canceled. Order ID: #{params[:order_id]}"
  end
  
  def notification
    puts "PAYPAL_NOTIFICATION with ORDER_ID: #{params[:order_id]}"
    render :text => "Notification Received. Order ID: #{params[:order_id]}"
  end
  
end