class Api::V1::EventsController < Api::BaseController
    
    # Get Events
    def index
      if !params[:category_ids].nil?
        @events = Event.where(category_id: params[:category_ids])
      else
        @events = Event.all
      end
    end
    
end