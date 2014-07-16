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
    
end