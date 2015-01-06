class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues, id: :uuid do |t|
      t.string  :name
      t.string  :city
      t.string  :address
      t.string  :layout_map_url
      t.timestamps
    end
  end
end
