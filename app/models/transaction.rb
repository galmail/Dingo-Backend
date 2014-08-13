# == Schema Information
#
# Table name: transactions
#
#  id            :uuid             not null, primary key
#  sender_id     :integer
#  receiver_id   :integer
#  ticket_id     :uuid
#  creditcard_id :uuid
#  event_id      :uuid
#  offer_id      :uuid
#  num_tickets   :integer          default(1)
#  amount        :decimal(8, 2)
#  status        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Transaction < ActiveRecord::Base
  
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  belongs_to  :offer
  belongs_to  :event
  
  #TODO Not implemented yet
  def release_payment
    
    # Step 1: Set the transaction status as "successful".
    # Step 2: Send money to seller and the commision to dingo.
    # Step 3: Notify Dingo by email about the transaction.
    # Step 4: Notify the buyer and the seller by email about the transaction.
    
  end
  
  #TODO Not implemented yet
  def abort_payment
    
    # Step 1: Set the transaction status as "failed".
    # Step 2: Set the reason of failure: eg. ticket already sold on other website, fake ticket, not delivered on time.
    # Step 3: Send money back to the buyer.
    # Step 4: Notify Dingo by email about the transaction.
    # Step 5: Notify the buyer and the seller by email about the transaction.
    
  end
  
  #TODO Not implemented yet
  def open_dispute
    
    # Step 1: Set the transaction status as "dispute".
    # Step 2: Get explanation from both buyer and seller.
    # Step 3: Send Paypal the disputed transaction.
    # Step 4: Notify Dingo by email about the transaction.
    # Step 5: Notify the buyer and the seller by email about the transaction.
    
  end
  
  #TODO Not implemented yet
  def close_dispute
    
    # Step 1: Set the transaction status as "resolved".
    # Step 2: Either release or abort the payment.
    
  end
  
end
