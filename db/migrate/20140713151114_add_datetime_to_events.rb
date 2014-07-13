class AddDatetimeToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :date, :datetime
    add_index   :events, :date
  end
end
