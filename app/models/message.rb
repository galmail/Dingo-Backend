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
#

class Message < ActiveRecord::Base
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  
  def notify
    device_token = User.find(self.receiver_id).devices.first.uid
    APNS.send_notification(device_token, self.content)
  end
  
end
