class Api::V1::UsersController < Api::BaseController
  
  # Update User's Profile
  def create
    user_data = user_params
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
  
  private
  
  def user_params
    params[:name] = URI.unescape(params[:name]) if params[:name].present?
    params[:surname] = URI.unescape(params[:surname]) if params[:surname].present?
    params[:city] = URI.unescape(params[:city]) if params[:city].present?
    if params[:promo].present?
      current_user.validate_promo(params[:promo])
    end
    params.permit(:email,:password,:name,:surname,:photo_url,:date_of_birth,:city,:allow_push_notifications,:allow_dingo_emails,:fb_id,:paypal_account)
  end
  
end