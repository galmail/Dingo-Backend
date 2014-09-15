class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column  :orders, :buyers_note, :text
    add_column  :orders, :delivery_options, :string
  end
end
