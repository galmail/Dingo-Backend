class Api::V1::UsersController < Api::BaseController
  
  # Update User's Profile
  def update
    puts "updating user..."
    user_data = params.permit(:name,:photo_url,:date_of_birth,:city)
    current_user.update_all(user_data)
    render :json => user.as_json
  end
  
  
end