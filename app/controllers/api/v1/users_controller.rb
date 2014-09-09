class Api::V1::UsersController < Api::BaseController
  
  # Update User's Profile
  def create
    user_data = params.permit(:name,:surname,:photo_url,:date_of_birth,:city,:allow_dingo_emails,:allow_push_notifications)
    
    if params[:disconnect_fb_account]
      user_data[:fb_id] = nil
    end
    
    current_user.update_attributes(user_data)
    render :json => current_user.as_json
  end
  
  
end