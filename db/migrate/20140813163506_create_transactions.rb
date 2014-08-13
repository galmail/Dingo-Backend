class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions, id: :uuid do |t|
      t.references  :sender
      t.references  :receiver
      t.uuid        :ticket_id
      t.uuid        :event_id
      t.uuid        :offer_id
      t.integer     :num_tickets, default: 1
      t.decimal     :price, precision: 8, scale: 2
      t.string      :status
      t.timestamps
    end
  end
end
