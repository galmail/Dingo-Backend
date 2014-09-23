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

    @messages = Message.where(filters).where(conditions.insert(0,query)).order('created_at DESC').limit(100)
  end

  # Send Message
  def create
    params.require(:receiver_id)
    params.require(:content)
    message_params = params.permit(:receiver_id, :content, :ticket_id, :new_offer)
    #TODO check if user is blocked
    
    
    
    message = Message.new(message_params)
    message.sender = current_user
    if message.save
      message.notify
      render :json=> message.as_json, status: :created
    else
      render :json=> message.errors, status: :unprocessable_entity
    end
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