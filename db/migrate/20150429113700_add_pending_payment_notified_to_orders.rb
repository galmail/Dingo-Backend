class AddPendingPaymentNotifiedToOrders < ActiveRecord::Migration
  def change
    add_column  :orders, :pending_payment_notified, :boolean, default: false
  end
end
