class Api::V1::EventsController < Api::BaseController
    
    # Get Events
    def index
      filters = { active: true }
      query = ""
      conditions = []
      
      # get_events_by_categories
      if params.has_key?(:category_ids)
        filters[:category_id] = params[:category_ids]
      end
      
      # get_featured_events
      if params.has_key?(:featured)
        filters[:featured] = params[:featured]
      end
      
      # get_inactive_events
      if params[:any]
        filters.delete(:active)
      end
      
      # search_events_by_name
      if params.has_key?(:name)
        query << and_query(query) << "name ILIKE ?"
        conditions << "%#{params[:name]}%"
      end
      
      # get_events_by_location
      if params.has_key?(:city)
        query << and_query(query) << "city ILIKE ?"
        conditions << "#{params[:city]}"
      elsif params.has_key?(:location)
        query << and_query(query) << "city ILIKE ?"
        conditions << "#{get_city(params[:location])}"
      end
      
      # search_events_by_date
      if params.has_key?(:start_date)
        query << and_query(query) << "date >= ?"
        conditions << "#{params[:start_date]}".to_date
      end
      if params.has_key?(:end_date)
        query << and_query(query) << "date < ?"
        conditions << ("#{params[:end_date]}".to_date + 1.day)
      end
      
      @events = Event.where(filters).where(conditions.insert(0,query)).order('date ASC').limit(100)
      
    end
    
    # Create Event
    def create
      params.require(:name)
      params.require(:date)
      params.require(:category_id)
      event_params = params.permit(:name, :description, :date, :end_date, :category_id, :address, :postcode, :city, :photo)
      
      params[:photo].content_type=params[:photo].content_type.split(";")[0].strip if params[:photo].present?
      
      event = Event.new(event_params)
      event.active = false
      event.created_by = current_user
      if event.save
        EventNotifier.report_new_event_to_dingo(event).deliver
        render :json=> event.as_json, status: :created
      else
        render :json=> event.errors, status: :unprocessable_entity
      end
    end
    
    private
    
    def get_city(location)
      res = Geocoder.search(params[:location])
      if res.length>0
        addr = res[0].data["address_components"]
        if addr.length>0
          addr.each { |obj|
            return obj["long_name"] if obj["types"].include?("locality")
          }
        end
      end
      return nil
    end
    
    def and_query(query)
      if query.length>0
        return " AND "
      else
        return ""
      end
    end
    
end