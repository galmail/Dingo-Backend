class Api::V1::PaypalController < Api::BaseController
  
  include PayPal::SDK::OpenIDConnect
  
  # Paypal handlers
  def index
    puts params.inspect
    render :json => params.as_json
  end
  
  def success
    puts "PAYPAL_SUCCESS with ORDER_ID: #{params[:order_id]}"
    current_order = Order.find(params[:order_id])
    current_order.status = 'AUTHORISED'
    current_order.paypal_key = params[:paypal_key]
    current_order.save
    
    # sending push notifications to both users (buyer and seller) 
    message_to_buyer = Message.new({
      :sender_id => current_order.receiver_id,
      :receiver_id => current_order.sender_id,
      :ticket_id => current_order.ticket_id,
      :from_dingo => true,
      :content => "Hi, this is Dingo... Congratulations, you have bought your ticket(s)! You are now in a chat with the seller. Please arrange delivery of your ticket(s) using this chat screen."
    })
    message2_to_buyer = Message.new({
      :sender_id => current_order.receiver_id,
      :receiver_id => current_order.sender_id,
      :ticket_id => current_order.ticket_id,
      :from_dingo => true,
      :content => "Your money will be held by Dingo, we will transfer it to #{current_order.receiver.name} 48 hours after the event takes place. If there are any issues you must get in contact with us before the transfer is made."
    })
    message_to_seller = Message.new({
      :sender_id => current_order.sender_id,
      :receiver_id => current_order.receiver_id,
      :ticket_id => current_order.ticket_id,
      :from_dingo => true,
      :content => "Hi, this is Dingo… Congratulations, your ticket(s) have been sold! You are now in a chat with the buyer, #{current_order.sender.name}. Please arrange delivery of the ticket(s) using this chat screen."
    })
    message2_to_seller = Message.new({
      :sender_id => current_order.sender_id,
      :receiver_id => current_order.receiver_id,
      :ticket_id => current_order.ticket_id,
      :from_dingo => true,
      :content => "#{current_order.sender.name} has paid and Dingo will transfer you the money 48 hours after the event takes place. If you haven’t already, please click the \"Sign in with PayPal\" button in the Sell Tickets page so we can register your PayPal details."
    })
    
    message_to_buyer.save
    message2_to_buyer.save
    message_to_seller.save
    message2_to_seller.save
    
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
    current_order.paypal_key = params[:paypal_key]
    current_order.save
    
    render :json=> current_order.as_json, status: :ok
    #render :text => "Payment Canceled. Order ID: #{params[:order_id]}"
  end
  
  def notification
    puts "PAYPAL_NOTIFICATION with ORDER_ID: #{params[:order_id]}"
    
    render :json=> Order.find(params[:order_id]).as_json, status: :ok
    #render :text => "Notification Received. Order ID: #{params[:order_id]}"
  end
  
  def connect
    code = params[:code]
    PayPal::SDK.configure({
      :openid_client_id     => ENV['PAYPAL_CLIENTID'],
      :openid_client_secret => ENV['PAYPAL_SECRET'],
      :openid_redirect_uri  => "http://dingoapp.co.uk"
    })
    puts "Got the autorization_code: #{code}"
    puts Tokeninfo.authorize_url( :scope => "openid profile" )
    # get access token and then get the user email
    tokeninfo = Tokeninfo.create(code)
    puts "Got Token1"
    puts tokeninfo.to_hash
    # Refresh tokeninfo object
    tokeninfo = tokeninfo.refresh
    puts "Got Token2"
    puts tokeninfo.to_hash
    # Create tokeninfo by using refresh token
    tokeninfo = Tokeninfo.refresh(tokeninfo)
    puts "Got Token3"
    puts tokeninfo.to_hash
    # Get Userinfo
    userinfo = tokeninfo.userinfo
    puts "User Info"
    puts userinfo.to_hash
    
    render :json=> userinfo.as_json, status: :ok
  end
  
end