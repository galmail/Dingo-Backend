class Api::V1::MessagesController < Api::BaseController
  # Get Messages
  def index
    query = ""
    conditions = []
    filters = { visible: true }

    if params.has_key?(:sender_id)
      filters[:sender_id] = params[:sender_id]
    end

    if params.has_key?(:receiver_id)
      filters[:receiver_id] = params[:receiver_id]
    end

    query << and_query(query) << "(sender_id = ? OR receiver_id = ?)"
    conditions << current_user.id
    conditions << current_user.id

    if params.has_key?(:content)
      query << and_query(query) << "content ILIKE ?"
      conditions << "%#{params[:content]}%"
    end
    
    if params.has_key?(:conversation_id)
      filters[:conversation_id] = params[:conversation_id]
    end

    @messages = Message.where(filters).where(conditions.insert(0,query)).order('created_at DESC').limit(Settings.MESSAGES_LIMIT.to_i)
    
    if params.has_key?(:conversation_id)
      @messages.to_a.delete_if { |msg| msg.from_dingo and msg.sender_id == current_user.id }
    end
    
  end

  # Send Message
  def create
    params.require(:receiver_id)
    params.require(:content)
    
    if User.find_by_id(params[:receiver_id]).blocked_users.include?(current_user)
      render :json=> {error: 'The user has blocked you.'}, status: :forbidden
      return false
    end
    
    message_params = params.permit(:receiver_id, :content, :ticket_id, :new_offer, :read, :from_dingo, :visible)
    message = Message.new(message_params)
    message.sender = current_user
    if message.save
      render :json=> message.as_json, status: :created
    else
      render :json=> message.errors, status: :unprocessable_entity
    end
  end
  
  # Mark Message as Read
  def update
    params.require(:id)
    msg = Message.find(params[:id])
    msg.read = true
    msg.save
    render :json => msg.as_json, status: :ok
  end
  
  def peers
    conversations = []
    filters = { visible: true }
    query = "(sender_id = ? OR receiver_id = ?)"
    conditions = [current_user.id,current_user.id]
    
    messages = Message.where(filters).where(conditions.insert(0,query)).order('created_at DESC').select(:id,:conversation_id,:sender_id,:receiver_id,:ticket_id,:created_at).distinct
    messages = messages.to_a.uniq { |msg| msg.conversation_id }
    
    messages.each { |msg|
      msg = Message.find(msg.id)
      peer = msg.get_peer(current_user.id)
      conversations << { :id => msg.conversation_id, :user_id => peer.id, :user_name => peer.name, :user_pic => peer.photo_url, :event_name => msg.get_event_name, :last_msg_sent => msg.created_at, :last_msg_read => (msg.read or msg.receiver_id!=current_user.id) }
    }
    render :json => conversations.as_json, status: :ok
  end
  
  def mark_all_as_read
    params.require(:conversation_id)
    Message.where(:conversation_id => params[:conversation_id]).update_all(:read => true)
    render :json => { :num_unread_messages => current_user.num_unread_messages }, status: :ok
  end
  
  def send_all_a_message
    params.require(:msg)
    users = User.where(:banned => false)
    users.each { |u|
      msg = Message.new({
        :content => params[:msg],
        :sender_id => Settings.DINGO_USER_ID,
        :receiver_id => u.id,
        :from_dingo => true
      })
      msg.notify
    }
    render :json => { :num_messages_sent => users.count }, status: :ok
  end
  
  
  private

  def and_query(query)
    if query.length>0
      return " AND "
    else
      return ""
    end
  end

end