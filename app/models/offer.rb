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
    device_token = User.find(self.receiver_id).devices.first.uid
    APNS.send_notification(device_token, self.price)
  end
  
  def notify_back
    device_token = User.find(self.sender_id).devices.first.uid
    APNS.send_notification(device_token, self.price)
  end
  
end
