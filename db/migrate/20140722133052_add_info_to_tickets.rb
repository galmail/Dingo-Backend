class AddInfoToTickets < ActiveRecord::Migration
  def change
    add_column  :tickets, :delivery_options, :string
    add_column  :tickets, :payment_options, :string
    add_column  :tickets, :number_of_tickets, :integer
    add_column  :tickets, :face_value_per_ticket, :decimal, precision: 8, scale: 2
  end
end
