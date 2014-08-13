# == Schema Information
#
# Table name: transactions
#
#  id          :uuid             not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  ticket_id   :uuid
#  event_id    :uuid
#  offer_id    :uuid
#  num_tickets :integer          default(1)
#  price       :decimal(8, 2)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Transaction < ActiveRecord::Base
  
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  belongs_to  :offer
  belongs_to  :event
  
  def release_payment
    #TODO Not implemented yet
  end
  
end
