class Api::V1::AlertsController < Api::BaseController
    
    def index
      filters = { active: true, :user_id => current_user.id }
      
      # get_alerts_by_event
      if params.has_key?(:event_id)
        filters[:event_id] = params[:event_id]
      end
      
      @alerts = Alert.where(filters)
    end
    
    def create
      params.require(:event_id)
      params.require(:price)
      params.require(:on)
      return set_alert(params[:event_id],params[:on],params[:price],params[:description])
    end
    
    private
    
    # Set an alert
    def set_alert(event_id,active,price,description)
      # check if alert already exist
      current_alert = Alert.where(:event_id => event_id, :user_id => current_user.id).first
      if !current_alert.nil?
        current_alert.price = price
        current_alert.active = active
        current_alert.description = description
      else
        current_alert = Alert.new({
          :user_id => current_user.id,
          :event_id => event_id,
          :price => price,
          :description => description
        })
      end
      # save the alert
      if current_alert.save
        render :json=> current_alert.as_json
      else
        render :json=> current_alert.errors, status: :unprocessable_entity
      end
    end
    
end