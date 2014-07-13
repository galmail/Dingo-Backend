class SessionsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User
  
  respond_to :json
  
  def new
    if user_signed_in?
      render :json => { :success => true }
    else
      render :json => { :success => false }, status: :unauthorized
    end
  end
  

end