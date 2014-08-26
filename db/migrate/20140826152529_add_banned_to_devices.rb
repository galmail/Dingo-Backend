class AddBannedToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :banned, :boolean, default: false
  end
end
