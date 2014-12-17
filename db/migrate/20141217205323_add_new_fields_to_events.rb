class AddNewFieldsToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :min_price, :decimal, precision: 8, scale: 2, default: 0
    add_column  :events, :available_tickets, :integer, default: 0
  end
end
