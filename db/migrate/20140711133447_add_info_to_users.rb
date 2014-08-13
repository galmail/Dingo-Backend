class AddInfoToUsers < ActiveRecord::Migration
  
  def self.up
    add_column :users, :name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :city, :string
    add_column :users, :photo_url, :string
  end
  
  def self.down
    remove_column :users, :name, :string
    remove_column :users, :date_of_birth, :date
    remove_column :users, :city, :string
    remove_column :users, :photo_url, :string
  end
  
end
