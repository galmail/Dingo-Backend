class AddDescriptionToAlerts < ActiveRecord::Migration
  def change
    add_column  :alerts, :description, :string 
  end
end
