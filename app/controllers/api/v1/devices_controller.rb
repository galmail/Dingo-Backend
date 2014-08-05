class Api::V1::DevicesController < Api::BaseController
    
    # Register Ticket
    def create
      device_params = params.permit(:uid, :brand, :model, :os, :app_version, :mobile_number, :ip, :location)
      
      device = Device.new(device_params)
      device.user = current_user
      if device.save
        render :json=> device.as_json
      else
        render :json=> device.errors, status: :unprocessable_entity
      end
    end
    
end