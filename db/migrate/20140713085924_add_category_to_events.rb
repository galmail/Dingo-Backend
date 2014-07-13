class AddCategoryToEvents < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.references :category
    end
    add_index :events, :category_id
  end
  
  def down
    remove_column :events, :category_id
  end
end
