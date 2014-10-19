# == Schema Information
#
# Table name: categories
#
#  id                 :uuid             not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Category < ActiveRecord::Base
  
  has_attached_file    :photo, :styles => { :medium => "300x300#", :thumb => "200x200#", :tiny_pic => "100x100#" }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  validates_presence_of :name
  validates_attachment_presence :photo
  
  has_many :events
  
end
