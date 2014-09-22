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
  
  def notify
    msg = "#{self.sender.name} offers you #{self.price} for #{self.num_tickets} ticket to #{self.ticket.event.name}"
    message = Message.new({
      :sender_id => self.sender.id,
      :receiver_id => self.receiver.id,
      :ticket_id => self.ticket.id,
      :content => msg,
      :from_dingo => true,
      :new_offer => true
    })
    if message.save
      return message.notify
    else
      return false
    end
  end
  
  def notify_back
    msg = ""
    if self.accepted
      msg = "Congrats! #{self.receiver.name} has accepted your offer"
    elsif self.rejected
      msg = "#{self.receiver.name} has declined your offer"
    end
    message = Message.new({
      :sender_id => self.receiver.id,
      :receiver_id => self.sender.id,
      :ticket_id => self.ticket.id,
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
  
end
