class AddPrimaryTicketUrlToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :primary_ticket_seller_url, :string
  end
end
