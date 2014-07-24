class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers, id: :uuid do |t|
      t.references  :sender
      t.references  :receiver
      t.uuid        :ticket_id
      t.integer     :num_tickets, default: 1
      t.decimal     :price, precision: 8, scale: 2
      t.boolean     :accepted, default: false
      t.boolean     :rejected, default: false
      t.timestamps
    end
  end
end
