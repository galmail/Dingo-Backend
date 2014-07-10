class Api::V1::EventsController < Api::BaseController
    
    # Get All Events
    def index
      @events = Event.all
    end
    
end