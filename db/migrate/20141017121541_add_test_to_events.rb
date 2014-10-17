class AddTestToEvents < ActiveRecord::Migration
  def change
    add_column :events, :test, :boolean, default: false
  end
end
