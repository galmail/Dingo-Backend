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
  
  validates_presence_of :sender
  validates_presence_of :receiver
  validates_presence_of :ticket
  validates_presence_of :event
  
  before_save :check_status
  
  def check_status
    valid_status = ['NOT_CREATED','PENDING','AUTHORISED','COMPLETED','REFUNDED','CANCELED','DISPUTE'] 
    valid_status.include?(self.status)
  end
  
  # This method is now deprecated
  def pay
    return false
    # @api = PayPal::SDK::AdaptivePayments.new
    # @payment = @api.build_pay({
      # :actionType => "PAY_PRIMARY",
      # :feesPayer => "PRIMARYRECEIVER",
      # :currencyCode => "GBP",
      # :reverseAllParallelPaymentsOnError => true,
      # :returnUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/success?order_id=#{self.id}",
      # :cancelUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/cancel?order_id=#{self.id}",
      # :ipnNotificationUrl => "http://dingoapp.herokuapp.com/api/v1/paypal/notification?order_id=#{self.id}",
      # :receiverList => {
        # :receiver => [
          # {
            # :primary => true,
            # :amount => self.amount,
            # :email => Settings.DINGO_EMAIL
          # },
          # {
            # :primary => false,
            # :amount => self.sellers_profit,
            # :email => self.receiver.email
          # }
        # ]
      # }
    # })
    # @api.pay(@payment)
  end
  
  # This method is now deprecated
  def release_payment
    return false
    # @api = PayPal::SDK::AdaptivePayments::API.new
    # @execute_payment = @api.build_execute_payment({:payKey => self.paypal_key})
    # @execute_payment_response = @api.execute_payment(@execute_payment)
    # if @execute_payment_response.success?
      # self.status = "COMPLETED"
      # self.save
    # end
    # return @execute_payment_response
  end
  
  # This method is now deprecated
  def refund_payment
    return false
    # @api = PayPal::SDK::AdaptivePayments::API.new
    # @refund = @api.build_refund({
      # :currencyCode => "GBP",
      # :payKey => self.paypal_key,
      # :receiverList => {
        # :receiver => [{
          # :amount => self.amount,
          # :email => self.sender.email
        # }]
      # }
    # })
    # @refund_response = @api.refund(@refund)
    # if @refund_response.success?
      # self.status = "REFUNDED"
      # self.save
    # end
    # return @refund_response
  end
  
  def open_dispute
    self.status = "DISPUTE"
    self.save
    # Step 1: Notify Dingo by email about the order's dispute.
    OrderNotifier.report_dispute_to_dingo(self).deliver
    # Step 2: Notify the buyer and the seller by email about the order's dispute.
    OrderNotifier.notify_dispute_to_user(self,self.sender).deliver
    OrderNotifier.notify_dispute_to_user(self,self.receiver).deliver
  end
  
  def close_dispute
    # Step 1: Set the order status as "resolved".
    # Step 2: Either release or abort the payment.
  end
  
  def buyers_amount
    return (self.amount * 1.10)
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
