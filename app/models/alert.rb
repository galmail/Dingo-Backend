# == Schema Information
#
# Table name: alerts
#
#  id         :uuid             not null, primary key
#  user_id    :integer
#  event_id   :uuid
#  price      :decimal(8, 2)
#  created_at :datetime
#  updated_at :datetime
#  on         :boolean          default(TRUE)
#

class Alert < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  
  # TODO Not implemented yet
  def notify_user
    
  end
  
end
