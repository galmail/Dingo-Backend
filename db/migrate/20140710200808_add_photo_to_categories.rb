class AddPhotoToCategories < ActiveRecord::Migration
  def self.up
    add_attachment :categories, :photo
  end

  def self.down
    remove_attachment :categories, :photo
  end
end
