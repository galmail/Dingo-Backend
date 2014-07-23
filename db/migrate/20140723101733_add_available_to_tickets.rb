class AddAvailableToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :available, :boolean, default: true
  end
end
