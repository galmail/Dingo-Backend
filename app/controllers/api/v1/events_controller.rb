class Api::V1::EventsController < Api::BaseController
    
    # Get Events
    def index
      filters = { active: true }
      conditions = []
      
      # get_events_by_categories
      if params.has_key?(:category_ids)
        filters[:category_id] = params[:category_ids]
      end
      
      # get_featured_events
      if params.has_key?(:featured)
        filters[:featured] = params[:featured]
      end
      
      # search_events_by_name
      if params.has_key?(:name)
        conditions = ["name ILIKE ?","%#{params[:name]}%"]
      end
      
      # get_events_by_location
      if params.has_key?(:location) or params.has_key?(:city)
        
      end
      
      @events = Event.where(filters).where(conditions).order('date ASC').limit(100)
      
    end
    
    # Create Event
    def create
      params.require(:name)
      params.require(:date)
      params.require(:category_id)
      event_params = params.permit(:name, :description, :date, :category_id, :address, :postcode, :city, :photo)
      
      params[:photo].content_type=params[:photo].content_type.split(";")[0].strip if params[:photo].present?
      
      
      puts "ContentType:" + params[:photo].content_type.to_s
      puts "Headers" + params[:photo].headers.to_s
      puts "FileName" + params[:photo].original_filename.to_s
      puts "TempFile" + params[:photo].tempfile.to_s
      
      
      
      #event.photo = params[:photo] if params[:photo].present?
      event = Event.new(event_params)
      
      
      event.created_by=current_user
      if event.save
        render :json=> event.as_json, status: :created
      else
        render :json=> event.errors, status: :unprocessable_entity
      end
    end
    
    
end