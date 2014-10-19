class OrderNotifier < ActionMailer::Base
  default :from => "\"Dingo Team\" <#{Settings.DINGO_EMAIL}>"

  def dingo_email
    "\"Dingo Team\" <#{Settings.DINGO_EMAIL}>"
  end
  
  # report dispute to Dingo
  def report_dispute_to_dingo(the_order)
    @order = the_order
    mail(:from => self.dingo_email,:to => Settings.DINGO_EMAIL,:subject => 'Order Dispute Initiated')
  end
  
  # notify the user that his order is under dispute
  def notify_dispute_to_user(the_order,the_user)
    @order = the_order
    @user = the_user
    mail(:from => self.dingo_email,:to => the_user.email,:subject => 'Order Dispute Initiated')
  end
  
  
  
  
end