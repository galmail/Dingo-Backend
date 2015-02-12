class UserNotifier < ActionMailer::Base
  default :from => "\"Dingo Team\" <#{Settings.DINGO_EMAIL}>"

  def dingo_email
    "\"Dingo Team\" <#{Settings.DINGO_EMAIL}>"
  end
  
  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_signup_email(user)
    @user = user
    mail(:from => self.dingo_email, :to => @user.inbox_email,:subject => 'Thanks for signing up to Dingo' )
  end
  
  # send a signup email to the user, pass in the user object that contains the user's email address
  def report_user_to_dingo(notifier_user,reported_user)
    @reported_user = reported_user
    @notifier_user = notifier_user
    mail(:from => self.dingo_email,:to => Settings.DINGO_EMAIL,:subject => 'User has been Reported')
  end
  
  def confirm_reported_user_to_notifier(notifier_user,reported_user)
    @reported_user = reported_user
    @notifier_user = notifier_user
    mail(:from => self.dingo_email,:to => notifier_user.inbox_email,:subject => 'You have reported a user')
  end
  
  
  
end