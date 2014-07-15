class AddInfoToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :active, :boolean, :default => true
    add_column  :events, :address, :string
    add_column  :events, :postcode, :string
    add_column  :events, :featured, :boolean, :default => false
  end
end
