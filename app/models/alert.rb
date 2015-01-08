# == Schema Information
#
# Table name: alerts
#
#  id          :uuid             not null, primary key
#  user_id     :integer
#  event_id    :uuid
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#  active      :boolean          default(TRUE)
#

class Alert < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  
  validates_presence_of :user
  validates_presence_of :event
  validates_presence_of :price
  
  def notify_user(price)
    # send user push notification
    msg = "New tickets for #{self.event.name} are now selling for £#{price}"
    message = Message.new({
      :sender_id => Settings.DINGO_USER_ID,
      :receiver_id => self.user.id,
      :content => msg,
      :from_dingo => true
    })
    if message.save
      return message.notify
    else
      return false
    end
  end
  
end
