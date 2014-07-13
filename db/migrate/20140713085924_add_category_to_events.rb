class AddCategoryToEvents < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.uuid :category_id
    end
    add_index :events, :category_id
  end
  
  def down
    remove_column :events, :category_id
  end
end
