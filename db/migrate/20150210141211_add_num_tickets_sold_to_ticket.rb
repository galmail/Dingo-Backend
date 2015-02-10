class AddNumTicketsSoldToTicket < ActiveRecord::Migration
  def change
    add_column  :tickets, :number_of_tickets_sold, :integer, default: 0
  end
end
