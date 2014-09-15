class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: :uuid do |t|
      t.references  :sender
      t.references  :receiver
      t.uuid        :ticket_id
      t.uuid        :creditcard_id
      t.uuid        :event_id
      t.uuid        :offer_id
      t.integer     :num_tickets, default: 1
      t.decimal     :amount, precision: 8, scale: 2
      t.string      :status
      t.timestamps
    end
  end
end
