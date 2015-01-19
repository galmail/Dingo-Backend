class Api::V1::TicketsController < Api::BaseController
    
    # Get Tickets
    def index
      filters = { available: true }
      conditions = []
      
      # get_tickets_by_event
      if params.has_key?(:event_id)
        filters[:event_id] = params[:event_id]
      end
      
      # get_tickets_by_user
      if params.has_key?(:auth_token)
        filters[:user_id] = User.where(authentication_token: params[:auth_token]).first.id
        #filters.delete(:available)
      end
      
      @tickets = Ticket.where(filters).where(conditions).order('price ASC').limit(100)
    end
    
    # Create Ticket
    def create
      
      params.require(:event_id)
      params.require(:price)
      ticket_params = params.permit(:event_id, :price, :seat_type, :ticket_type, :description, :photo1, :photo2, :photo3, :delivery_options, :payment_options, :number_of_tickets, :face_value_per_ticket)
      
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
    
    # Update Ticket
    def update
      params.require(:id)
      
      ticket_params = params.permit(:price, :seat_type, :ticket_type, :description, :photo1, :photo2, :photo3, :delivery_options, :payment_options, :number_of_tickets, :face_value_per_ticket, :available)
      
      params[:photo1].content_type=params[:photo1].content_type.split(";")[0].strip if params[:photo1].present?
      params[:photo2].content_type=params[:photo2].content_type.split(";")[0].strip if params[:photo2].present?
      params[:photo3].content_type=params[:photo3].content_type.split(";")[0].strip if params[:photo3].present?
      
      ticket = Ticket.find(params[:id])
      
      set_alert = false
      if params[:price] && ticket.price.to_f != params[:price].to_f
        set_alert = true
      end
      
      ticket.update_attributes(ticket_params)
      ticket.alert_buyers if set_alert
      render :json => ticket.as_json, status: :ok
    end
    
end