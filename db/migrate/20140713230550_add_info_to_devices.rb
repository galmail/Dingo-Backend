class AddInfoToDevices < ActiveRecord::Migration
  def change
    add_column  :devices, :ip, :string
    add_column  :devices, :location, :string
  end
end
