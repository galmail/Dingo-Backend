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
#  offer_id    :uuid
#  read        :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  belongs_to  :offer
  
  validates_presence_of :sender_id
  validates_presence_of :receiver_id
  validates_presence_of :content
  
  
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
  
  def sender_photo
    if self.from_dingo
      Settings.DINGO_LOGO
    else
      self.sender.photo_url
    end
  end
  
end
