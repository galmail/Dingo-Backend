class AddTicketTypeToTickets < ActiveRecord::Migration
  def change
    add_column  :tickets, :ticket_type, :string
  end
end
