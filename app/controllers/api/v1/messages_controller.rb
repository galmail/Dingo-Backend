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

    if params.has_key?(:conversations)
      if params[:conversations]
        query << and_query(query) << "(sender_id = ? OR receiver_id = ?)"
        conditions << current_user.id
        conditions << current_user.id
      end
    end

    if params.has_key?(:content)
      query << and_query(query) << "content ILIKE ?"
      conditions << "%#{params[:content]}%"
    end

    @messages = Message.where(filters).where(conditions.insert(0,query)).order('created_at DESC').limit(Settings.MESSAGES_LIMIT.to_i)
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

  private

  def and_query(query)
    if query.length>0
      return " AND "
    else
      return ""
    end
  end

end