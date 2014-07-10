class RegistrationsController < Devise::RegistrationsController

  respond_to :json
  
  def new
    user = User.new(user_params)
    user.password = "11111111111" if params[:password].nil?
    if user.save
      user.password = user.authentication_token unless !params[:password].nil?
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
    return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end
  
  private
  
  def user_params
    params.require(:email)
    params.permit(:email,:password)
  end

end