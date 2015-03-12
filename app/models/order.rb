# == Schema Information
#
# Table name: orders
#
#  id               :uuid             not null, primary key
#  sender_id        :integer
#  receiver_id      :integer
#  ticket_id        :uuid
#  creditcard_id    :uuid
#  event_id         :uuid
#  offer_id         :uuid
#  num_tickets      :integer          default(1)
#  amount           :decimal(8, 2)
#  status           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  paypal_key       :string(255)
#  buyers_note      :text
#  delivery_options :string(255)
#  promo_id         :uuid
#

class Order < ActiveRecord::Base
  
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  belongs_to  :offer
  belongs_to  :event
  belongs_to  :promo
  
  validates_presence_of :sender
  validates_presence_of :receiver
  validates_presence_of :ticket
  validates_presence_of :event
  
  before_save :check_status
  after_save  :apply_promo
  
  def check_status
    valid_status = ['NOT_CREATED','PENDING','AUTHORISED','COMPLETED','REFUNDED','CANCELED','DISPUTE'] 
    valid_status.include?(self.status)
  end
  
  def apply_promo
    if !self.promo.nil? and self.status=='AUTHORISED'
      self.sender.promo_used = true
      self.sender.save
    end
  end
  
  # This method is now deprecated
  def pay
    return false
  end
  
  def release_payment(mark_released)
    if mark_released
      self.status = 'COMPLETED'
      self.save
      OrderNotifier.notify_seller_payment_released(self).deliver
      # send push notification as well
      msg = "Dingo:Goods news - your money has been released! Check your emails for more info."
      message = Message.new({
        :sender_id => Settings.DINGO_USER_ID,
        :receiver_id => self.receiver.id,
        :content => msg,
        :from_dingo => true
      })
      message.save
      return true
    end
    
    if self.status == 'AUTHORISED'
      # just notify admin for now
      OrderNotifier.notify_pending_payment_release(self).deliver
      return true
    end
    
    return false
  end
  
  # This method is now deprecated
  def refund_payment
    return false
  end
  
  def open_dispute
    self.status = "DISPUTE"
    self.save
    # Step 1: Notify Dingo by email about the order's dispute.
    OrderNotifier.report_dispute_to_dingo(self).deliver
    # Step 2: Notify the buyer and the seller by email about the order's dispute.
    OrderNotifier.notify_dispute_to_user(self,self.sender).deliver
    OrderNotifier.notify_dispute_to_user(self,self.receiver).deliver
  end
  
  def close_dispute
    # Step 1: Set the order status as "resolved".
    # Step 2: Either release or abort the payment.
  end
  
  def buyers_amount
    return (self.amount * 1.10)
  end
  
  def total_commission
    return self.buyers_amount - self.amount
  end
  
  def dingo_commision
    return self.total_commission - self.paypal_commision 
  end
  
  def paypal_commision
    return (self.amount * 0.034) + 0.20
  end
  
  
end
