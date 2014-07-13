class AddDatetimeToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :date, :date
    add_index   :events, :date
  end
end
