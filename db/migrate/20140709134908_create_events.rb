class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
