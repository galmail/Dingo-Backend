class ChangeAlertOnColumn < ActiveRecord::Migration
  def change
    remove_column :alerts, :on, :boolean
    add_column    :alerts, :active, :boolean, default: true
  end
end
