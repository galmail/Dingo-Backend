class RegistrationsController < Devise::RegistrationsController

  respond_to :json
  
  def new
    verify_params
    user = User.new(user_params)
    user.password = "11111111111" if params[:password].nil?
    if user.save
      user.password = user.authentication_token unless params.has_key?(:password)
      if params.has_key?(:device_uid)
        device = Device.new(device_params)
        device.user_id = user.id
        device.save
      end
      UserNotifier.send_signup_email(user).deliver
      user.save
      render :json => user.as_json(:auth_token=>user.authentication_token, :email=>user.email), status: :created
    else
      warden.custom_failure!
      render :json => user.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def verify_params
    params.require(:email)
    params.permit(:email,:password,:name,:surname,:photo_url,:date_of_birth,:city,:device_uid,:device_brand,:device_model,:device_os,:device_app_version,:device_mobile_number,:device_location,:device_ip)
  end
  
  def user_params
    params[:name] = URI.unescape(params[:name]) if params[:name].present?
    params[:surname] = URI.unescape(params[:surname]) if params[:surname].present?
    params[:city] = URI.unescape(params[:city]) if params[:city].present?
    params.permit(:email,:password,:name,:surname,:photo_url,:date_of_birth,:city)
  end
  
  def device_params
    params.permit(:device_uid,:device_brand,:device_model,:device_os,:device_app_version,:device_mobile_number,:device_location,:device_ip)
    dmodel = nil
    dmodel = URI.unescape(params[:device_model]) if params[:device_model].present?
    return {
      :brand  => params[:device_brand],
      :model  => dmodel,
      :os     => params[:device_os],
      :uid    => params[:device_uid],
      :ip => params[:device_ip],
      :app_version => params[:device_app_version],
      :mobile_number => params[:device_mobile_number],
      :location => params[:device_location]
    }
  end

end