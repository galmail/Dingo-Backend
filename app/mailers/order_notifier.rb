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
    mail(:from => self.dingo_email,:to => the_user.inbox_email,:subject => 'Order Dispute Initiated')
  end
  
  def notify_ticket_purchased(the_order)
    @order = the_order
    @buyer = the_order.sender
    @seller = the_order.receiver
    mail(:from => self.dingo_email,:to => @buyer.inbox_email,:subject => 'Congrats you got your ticket!')
  end
  
  def notify_ticket_sold(the_order)
    @order = the_order
    @seller = the_order.receiver
    @buyer = the_order.sender
    mail(:from => self.dingo_email,:to => @seller.inbox_email,:subject => 'Congrats you have sold your ticket!')
  end
  
  def notify_successful_transaction(the_order)
    @order = the_order
    mail(:from => self.dingo_email,:to => Settings.DINGO_EMAIL,:subject => 'New Order!')
  end
  
  def notify_pending_payment_release(the_order)
    @order = the_order
    mail(:from => self.dingo_email,:to => Settings.DINGO_EMAIL,:subject => 'Pending Payment to Seller!')
  end
  
  def notify_seller_payment_released(the_order)
    @order = the_order
    mail(:from => self.dingo_email,:to => the_order.receiver.inbox_email,:subject => 'Another day another dollar...')
  end
  
end