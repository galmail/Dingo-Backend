class Api::V1::MessagesController < Api::BaseController
    
    # Get Messages
    def index
      query = ""
      conditions = []
      
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
      
      @messages = Message.where(filters).where(conditions).order('created_at DESC').limit(100)
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
    end
    
    def and_query(query)
      if query.length>0
        return " AND "
      else
        return ""
      end
    end
    
    
end