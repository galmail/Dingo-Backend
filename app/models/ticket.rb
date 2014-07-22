# == Schema Information
#
# Table name: tickets
#
#  id                  :uuid             not null, primary key
#  user_id             :integer
#  event_id            :uuid
#  price               :decimal(8, 2)
#  seat_type           :string(255)
#  description         :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  photo1_file_name    :string(255)
#  photo1_content_type :string(255)
#  photo1_file_size    :integer
#  photo1_updated_at   :datetime
#  photo2_file_name    :string(255)
#  photo2_content_type :string(255)
#  photo2_file_size    :integer
#  photo2_updated_at   :datetime
#  photo3_file_name    :string(255)
#  photo3_content_type :string(255)
#  photo3_file_size    :integer
#  photo3_updated_at   :datetime
#

class Ticket < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  
  has_attached_file    :photo1, :styles => { :thumb => "200x200#", :large => "400x400#" }
  has_attached_file    :photo2, :styles => { :thumb => "200x200#", :large => "400x400#" }
  has_attached_file    :photo3, :styles => { :thumb => "200x200#", :large => "400x400#" }
  #validates_attachment :photo1, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  
end