class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets, id: :uuid do |t|
      t.references :user
      t.uuid :event_id
      t.decimal :price, precision: 8, scale: 2
      t.string :seat_type
      t.string :description
      t.timestamps
    end
    add_index :tickets, :event_id
  end
end
