# == Schema Information
#
# Table name: orders
#
#  id               :uuid             not null, primary key
#  sender_id        :integer
#  receiver_id      :integer
#  ticket_id        :uuid
#  creditcard_id    :uuid
#  event_id         :uuid
#  offer_id         :uuid
#  num_tickets      :integer          default(1)
#  amount           :decimal(8, 2)
#  status           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  paypal_key       :string(255)
#  buyers_note      :text
#  delivery_options :string(255)
#

class Order < ActiveRecord::Base
  
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  belongs_to  :offer
  belongs_to  :event
  
  before_save :check_status
  
  def check_status
    valid_status = ['NOT_CREATED','PENDING','AUTHORISED','COMPLETED','REFUNDED','CANCELED','DISPUTE'] 
    valid_status.include?(self.status)
  end
  
  def pay
    @api = PayPal::SDK::AdaptivePayments.new
    @payment = @api.build_pay({
      :actionType => "PAY_PRIMARY",
      :feesPayer => "PRIMARYRECEIVER",
      :currencyCode => "GBP",
      :reverseAllParallelPaymentsOnError => true,
      :returnUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/success?order_id=#{self.id}",
      :cancelUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/cancel?order_id=#{self.id}",
      :ipnNotificationUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/notification?order_id=#{self.id}",
      :receiverList => {
        :receiver => [
          {
            :primary => true,
            :amount => self.amount,
            :email => Settings.DINGO_EMAIL
          },
          {
            :primary => false,
            :amount => self.sellers_profit,
            :email => self.receiver.email
          }
        ]
      }
    })
    @api.pay(@payment)
  end
  
  def release_payment
    @api = PayPal::SDK::AdaptivePayments::API.new
    @execute_payment = @api.build_execute_payment({:payKey => self.paypal_key})
    @execute_payment_response = @api.execute_payment(@execute_payment)
    if @execute_payment_response.success?
      self.status = "COMPLETED"
      self.save
      #TODO send push notifications and emails to both buyer and seller
      #TODO send email to Dingo Admin
    end
    return @execute_payment_response
  end
  
  def refund_payment
    @api = PayPal::SDK::AdaptivePayments::API.new
    @refund = @api.build_refund({
      :currencyCode => "GBP",
      :payKey => self.paypal_key,
      :receiverList => {
        :receiver => [{
          :amount => self.amount,
          :email => self.sender.email
        }]
      }
    })
    @refund_response = @api.refund(@refund)
    if @refund_response.success?
      self.status = "REFUNDED"
      #TODO Set the reason of failure: eg. ticket already sold on other website, fake ticket, not delivered on time.
      self.save
      #TODO Notify Dingo by email about the order.
      #TODO Notify the buyer and the seller by push notification and email about the order.
    end
    return @refund_response
  end
  
  #TODO Not Ready yet
  def open_dispute
    self.status = "DISPUTE"
    self.save
    # Step 1: Set the order status as "dispute".
    # Step 2: Get explanation from both buyer and seller.
    # Step 3: Send Paypal the disputed order.
    # Step 4: Notify Dingo by email about the order.
    # Step 5: Notify the buyer and the seller by email about the order.
  end
  
  #TODO Not implemented yet
  def close_dispute
    # Step 1: Set the order status as "resolved".
    # Step 2: Either release or abort the payment.
  end
  
  def sellers_profit
    return (self.amount * 0.90)
  end
  
  def dingos_profit
    return (self.amount * 0.10)
  end
  
  def dingo_commision
    return (self.amount * 0.10) - self.paypal_commision 
  end
  
  def paypal_commision
    return (self.amount * 0.034) + 0.20
  end
  
  
end
