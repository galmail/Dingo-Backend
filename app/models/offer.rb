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
    User.find(self.receiver_id).devices.each { |device|
      APNS.send_notification(device.uid, msg)
    }
  end
  
  def notify_back
    accepted_msg = "Congrats! #{self.receiver.name} has accepted your offer"
    rejected_msg = "#{self.receiver.name} has declined your offer"
    User.find(self.sender_id).devices.each { |device|
      if self.accepted
        APNS.send_notification(device.uid, accepted_msg)
      elsif self.rejected
        APNS.send_notification(device.uid, rejected_msg)
      end
    }
  end
  
end
