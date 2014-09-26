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
  
  # Method to allow a user block another user
  def block
    params.require(:user_id)
    params.require(:block)
    if params[:block]
      current_user.blocked_users.push(User.find(params[:user_id]))
    else
      current_user.blocked_users.delete(User.find(params[:user_id]))
    end
    render :json => current_user.as_json
  end
  
  # This method allow a user to report another user
  def report
    params.require(:user_id)
    # Report user to Dingo
    UserNotifier.report_user_to_dingo(current_user,User.find(params[:user_id])).deliver
    # Confirm to notifier, the user has been reported
    UserNotifier.confirm_reported_user_to_notifier(current_user,User.find(params[:user_id])).deliver
    render :json => current_user.as_json
  end
  
  
end