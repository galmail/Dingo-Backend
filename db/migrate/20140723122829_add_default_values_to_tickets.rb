class AddDefaultValuesToTickets < ActiveRecord::Migration
  def change
    change_column :tickets, :number_of_tickets, :integer, :default => 1
  end
end
