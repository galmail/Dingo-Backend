# == Schema Information
#
# Table name: messages
#
#  id          :uuid             not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  content     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  from_dingo  :boolean          default(FALSE)
#  new_offer   :boolean          default(FALSE)
#  visible     :boolean          default(TRUE)
#  ticket_id   :uuid
#

class Message < ActiveRecord::Base
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  
  def notify
    msg = "#{self.sender.name}: #{self.content}"
    if self.from_dingo
      msg = "#{self.content}"
    end
    User.find(self.receiver_id).devices.each { |device|
      APNS.send_notification(device.uid, msg)
    }
    return true
  end
  
end
