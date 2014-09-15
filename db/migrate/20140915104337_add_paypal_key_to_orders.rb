class AddPaypalKeyToOrders < ActiveRecord::Migration
  def change
    add_column  :orders, :paypal_key, :string
  end
end
