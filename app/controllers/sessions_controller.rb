class SessionsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  #acts_as_token_authentication_handler_for User
  #before_action :authenticate_user!
  
  respond_to :json
  
  def new
    verify_params
    myuser = User.find_for_authentication({:email => params[:email]})
    if (myuser.valid_password? params[:password] or myuser.authentication_token==params[:auth_token]) and (!myuser.banned?)
      render :json => {
        :success => true,
        :name => myuser.name,
        :surname => myuser.surname,
        :email => params[:email],
        :auth_token => myuser.authentication_token
      }
    else
      render :json => { :success => false }, status: :unauthorized
    end
  end
  
  def verify_params
    params.permit(:email,:password,:auth_token)
  end
  

end