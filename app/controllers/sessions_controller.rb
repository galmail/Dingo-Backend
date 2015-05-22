class SessionsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  #acts_as_token_authentication_handler_for User
  #before_action :authenticate_user!
  
  respond_to :json
  
  # login method
  def new
    verify_params
    myuser = User.find_for_authentication({:email => params[:email]})
    if !myuser.nil? and (myuser.valid_password?(params[:password]) or myuser.authentication_token==params[:auth_token]) and !myuser.banned?
      render :json => {
        :success => true,
        :id => myuser.id,
        :name => myuser.name,
        :surname => myuser.surname,
        :email => params[:email],
        :notification_email => myuser.notification_email,
        :auth_token => myuser.authentication_token,
        :allow_dingo_emails => myuser.allow_dingo_emails,
        :allow_push_notifications => myuser.allow_push_notifications,
        :fb_id => myuser.fb_id,
        :paypal_account => myuser.paypal_account,
        :num_unread_messages => myuser.num_unread_messages
      }
    else
      render :json => { :success => false }, status: :unauthorized
    end
  end
  
  def verify_params
    params.permit(:email,:password,:auth_token)
  end
  

end