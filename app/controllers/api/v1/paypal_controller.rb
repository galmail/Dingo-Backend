class Api::V1::PaypalController < Api::BaseController
  
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
      :ticket_id => current_order.ticket_id,
      :from_dingo => true,
      :content => 'Congrats! You have purchased a ticket. Please contact seller for collection.'
    })
    message_to_seller = Message.new({
      :sender_id => current_order.sender_id,
      :receiver_id => current_order.receiver_id,
      :ticket_id => current_order.ticket_id,
      :from_dingo => true,
      :content => "Congratulations, #{current_order.sender.name} has bought your ticket(s). Please arrange delivery."
    })
    
    message_to_buyer.save
    message_to_seller.save
    
    current_order.ticket.sold!(current_order.num_tickets)
    OrderNotifier.notify_ticket_purchased(current_order).deliver
    OrderNotifier.notify_ticket_sold(current_order).deliver
    OrderNotifier.notify_successful_transaction(current_order).deliver
    
    render :json=> current_order.as_json, status: :ok
    #render :text => "Payment Successful! Order ID: #{params[:order_id]}"
  end
  
  def cancel
    puts "PAYPAL_CANCEL with ORDER_ID: #{params[:order_id]}"
    
    current_order = Order.find(params[:order_id])
    current_order.status = 'CANCELED'
    current_order.save
    
    render :json=> current_order.as_json, status: :ok
    #render :text => "Payment Canceled. Order ID: #{params[:order_id]}"
  end
  
  def notification
    puts "PAYPAL_NOTIFICATION with ORDER_ID: #{params[:order_id]}"
    
    render :json=> Order.find(params[:order_id]).as_json, status: :ok
    #render :text => "Notification Received. Order ID: #{params[:order_id]}"
  end
  
end