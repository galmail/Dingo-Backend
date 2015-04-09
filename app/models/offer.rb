# == Schema Information
#
# Table name: offers
#
#  id          :uuid             not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  ticket_id   :uuid
#  num_tickets :integer          default("1")
#  price       :decimal(8, 2)
#  accepted    :boolean          default("false")
#  rejected    :boolean          default("false")
#  created_at  :datetime
#  updated_at  :datetime
#

class Offer < ActiveRecord::Base
  
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  
  validates_presence_of :sender
  validates_presence_of :receiver
  validates_presence_of :ticket
  
  after_save  :notify
  
  def notify
    return self.notify_accept_or_reject if self.accepted or self.rejected
      
    msg_to_seller = "#{self.sender.name} has requested to buy #{self.num_tickets} tickets for £#{self.price_per_ticket} per ticket. Total amount is £#{self.price}."
    message_to_seller = Message.new({
      :sender_id => self.sender.id,
      :receiver_id => self.receiver.id,
      :ticket_id => self.ticket.id,
      :offer_id => self.id,
      :content => msg_to_seller,
      :from_dingo => true,
      :new_offer => true
    })
    
    msg_to_buyer = "You have requested to buy #{self.num_tickets} tickets for £#{self.price_per_ticket} per ticket. Total is £#{self.price}."
    message_to_buyer = Message.new({
      :sender_id => self.receiver.id,
      :receiver_id => self.sender.id,
      :ticket_id => self.ticket.id,
      :offer_id => self.id,
      :content => msg_to_buyer,
      :from_dingo => true
    })
    
    if message_to_seller.save and message_to_buyer.save
      return true
    else
      return false
    end
  end
  
  def notify_accept_or_reject
    msg_to_buyer = ""
    msg_to_seller = ""
    if self.accepted
      msg_to_seller = "Offer accepted, we will let you know when payment has been received."
      msg_to_buyer = "Congrats! #{self.receiver.name} has accepted your offer."
    elsif self.rejected
      msg_to_seller = "Offer has been rejected."
      msg_to_buyer = "#{self.receiver.name} has rejected your offer."
    end
    message_to_buyer = Message.new({
      :sender_id => self.receiver.id,
      :receiver_id => self.sender.id,
      :ticket_id => self.ticket.id,
      :offer_id => self.id,
      :content => msg_to_buyer,
      :from_dingo => true,
      :new_offer => false
    })
    message_to_buyer.save
    
    message_to_seller = Message.new({
      :sender_id => self.sender.id,
      :receiver_id => self.receiver.id,
      :ticket_id => self.ticket.id,
      :offer_id => self.id,
      :content => msg_to_seller,
      :from_dingo => true,
      :new_offer => false
    })
    message_to_seller.save
    
    return true
  end
  
  def price_per_ticket
    self.price / self.num_tickets
  end
  
end
