class Category < ActiveRecord::Base
  
  has_attached_file    :photo, :styles => { :medium => "300x300#", :thumb => "200x200#" }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  
  has_many :events
  
end
