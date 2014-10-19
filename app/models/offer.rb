# == Schema Information
#
# Table name: offers
#
#  id          :uuid             not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  ticket_id   :uuid
#  num_tickets :integer          default(1)
#  price       :decimal(8, 2)
#  accepted    :boolean          default(FALSE)
#  rejected    :boolean          default(FALSE)
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
  
  def notify
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
      message_to_seller.notify
      message_to_buyer.notify
      return true
    else
      return false
    end
  end
  
  def notify_back
    msg = ""
    if self.accepted
      msg = "Congrats! #{self.receiver.name} has accepted your offer. Please pay here."
    elsif self.rejected
      msg = "#{self.receiver.name} has declined your offer"
    end
    message = Message.new({
      :sender_id => self.receiver.id,
      :receiver_id => self.sender.id,
      :ticket_id => self.ticket.id,
      :offer_id => self.id,
      :content => msg,
      :from_dingo => true,
      :new_offer => false
    })
    if message.save
      return message.notify
    else
      return false
    end
  end
  
  def price_per_ticket
    self.price / self.num_tickets
  end
  
end
