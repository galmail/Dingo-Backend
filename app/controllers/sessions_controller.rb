class SessionsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User
  
  respond_to :json
  
  def new
    render :json => { :success => user_signed_in? }
  end
  

end