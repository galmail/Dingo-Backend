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
#  on          :boolean          default(TRUE)
#  description :string(255)
#

class Alert < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  
  def notify_user
    # send user push notification
    msg = "New tickets for #{self.event.name} are now selling for #{self.event.min_price}"
    message = Message.new({
      :sender_id => self.user.id,
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
