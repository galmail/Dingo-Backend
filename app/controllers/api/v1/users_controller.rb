class Api::V1::UsersController < Api::BaseController
  
  # Update User's Profile
  def create
    user_data = params.permit(:name,:photo_url,:date_of_birth,:city)
    current_user.update_attributes(user_data)
    render :json => current_user.as_json
  end
  
  
end