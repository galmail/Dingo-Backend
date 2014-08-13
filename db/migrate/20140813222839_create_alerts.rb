class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts, id: :uuid do |t|
      t.references  :user
      t.uuid        :event_id
      t.decimal     :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
