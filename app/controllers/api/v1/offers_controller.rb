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

  # Send Offer
  def create
    params.require(:receiver_id)
    params.require(:ticket_id)
    params.require(:num_tickets)
    params.require(:price)
    offer_params = params.permit(:receiver_id, :ticket_id, :num_tickets, :price)

    offer = Offer.new(offer_params)
    offer.sender = current_user
    if offer.save
      send_offer(offer)
      render :json=> offer.as_json, status: :created
    else
      render :json=> offer.errors, status: :unprocessable_entity
    end
  end
  
  # Accept/Reject Offer
  def update
    params.require(:id)
    params.require(:accept_offer)
    offer_params = params.permit(:id, :accept_offer)
    offer = Offer.find(params[:id])
    offer.accepted = params[:accept_offer]
    offer.rejected = !params[:accept_offer]
    if offer.save
      notify_offer(offer)
      render :json=> offer.as_json, status: :updated
    else
      render :json=> offer.errors, status: :unprocessable_entity
    end
  end
  

  private

  # Sending offer via push to device: https://github.com/NicosKaralis/pushmeup
  def send_offer(offer)
    puts "Sending offer_id: #{offer.id} to receiver_id #{offer.receiver_id}"
    
    APNS.send_notifications(User.find(offer.receiver_id).devices.map { |device|
      APNS::Notification.new(device.uid, offer.price)
      #APNS::Notification.new(device.uid, :alert => msg.content, :badge => 1, :sound => 'default')
    })
  end
  
  # Notify offer via push to device: https://github.com/NicosKaralis/pushmeup
  def notify_offer(offer)
    puts "Notify offer_id: #{offer.id} back to sender_id #{offer.sender_id}"
    
    APNS.send_notifications(User.find(offer.sender_id).devices.map { |device|
      APNS::Notification.new(device.uid, offer.accepted)
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