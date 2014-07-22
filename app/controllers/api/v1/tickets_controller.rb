class Api::V1::TicketsController < Api::BaseController
    
    # Get Tickets
    def index
      filters = {}
      conditions = []
      
      # get_tickets_by_event
      if params.has_key?(:event_id)
        filters[:event_id] = params[:event_id]
      end
      
      # get_tickets_by_user
      if params.has_key?(:auth_token)
        filters[:user_id] = User.where(authentication_token: params[:auth_token])
      end
      
      @tickets = Ticket.where(filters).where(conditions).order('price ASC').limit(100)
    end
    
    # Create Ticket
    def create
      params.require(:event_id)
      params.require(:price)
      ticket_params = params.permit(:event_id, :price, :seat_type, :description, :photo1, :photo2, :photo3, :delivery_options, :payment_options, :number_of_tickets, :face_value_per_ticket)
      
      params[:photo1].content_type=params[:photo1].content_type.split(";")[0].strip if params[:photo1].present?
      params[:photo2].content_type=params[:photo2].content_type.split(";")[0].strip if params[:photo2].present?
      params[:photo3].content_type=params[:photo3].content_type.split(";")[0].strip if params[:photo3].present?
      
      ticket = Ticket.new(ticket_params)
      ticket.user = current_user
      if ticket.save
        render :json=> ticket.as_json, status: :created
      else
        render :json=> ticket.errors, status: :unprocessable_entity
      end
    end
    
    
end