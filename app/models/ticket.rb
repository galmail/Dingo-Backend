# == Schema Information
#
# Table name: tickets
#
#  id          :uuid             not null, primary key
#  user_id     :integer
#  event_id    :uuid
#  price       :decimal(8, 2)
#  seat_type   :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Ticket < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
end
