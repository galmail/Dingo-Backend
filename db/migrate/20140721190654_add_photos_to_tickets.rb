class AddPhotosToTickets < ActiveRecord::Migration
  def self.up
    add_attachment :tickets, :photo1
    add_attachment :tickets, :photo2
    add_attachment :tickets, :photo3
  end

  def self.down
    remove_attachment :tickets, :photo1
    remove_attachment :tickets, :photo2
    remove_attachment :tickets, :photo3
  end
end
