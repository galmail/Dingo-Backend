class Api::V1::OffersController < Api::BaseController
  
  # Get Offers
  def index
    query = ""
    conditions = []
    
    if !params.has_key?(:user_token) or (params.has_key?(:user_token) and params[:user_token]==current_user.authentication_token)
      query << and_query(query) << "(sender_id = ? OR receiver_id = ?)"
      conditions << current_user.id
      conditions << current_user.id
    elsif params.has_key?(:user_token)
      query << and_query(query) << "(sender_id = ? OR receiver_id = ?)"
      conditions << User.find_for_authentication({:authentication_token => params[:user_token]})
    end

    if params.has_key?(:sender_id)
      filters[:sender_id] = params[:sender_id]
    end

    if params.has_key?(:receiver_id)
      filters[:receiver_id] = params[:receiver_id]
    end

    @offers = Offer.where(filters).where(conditions).order('created_at DESC').limit(100)
  end

  # Send Message
  def create
    params.require(:receiver_id)
    params.require(:content)
    message_params = params.permit(:receiver_id, :content)

    message = Message.new(message_params)
    message.sender = current_user
    if message.save
      send_message(message)
      render :json=> message.as_json, status: :created
    else
      render :json=> message.errors, status: :unprocessable_entity
    end
  end

  private

  # Sending message via push to device: https://github.com/NicosKaralis/pushmeup
  def send_message(msg)
    puts "Sending message: #{msg.content} to receiver_id #{msg.receiver_id}"
    
    APNS.send_notifications(User.find(msg.receiver_id).devices.map { |device|
      APNS::Notification.new(device.uid, msg.content)
      #APNS::Notification.new(device.uid, :alert => msg.content, :badge => 1, :sound => 'default')
    })
  end

  def and_query(query)
    if query.length>0
      return " AND "
    else
      return ""
    end
  end

end