class AddVenueToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.uuid  :venue_id
    end
    add_index :events, :venue_id
  end
end
