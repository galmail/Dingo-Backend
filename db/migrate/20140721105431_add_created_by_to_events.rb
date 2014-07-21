class AddCreatedByToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.references :created_by
    end
  end
end
