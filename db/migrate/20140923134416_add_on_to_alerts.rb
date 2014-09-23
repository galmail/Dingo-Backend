class AddOnToAlerts < ActiveRecord::Migration
  def change
    add_column  :alerts, :on, :boolean, default: true
  end
end
