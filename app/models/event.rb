# == Schema Information
#
# Table name: events
#
#  id                 :uuid             not null, primary key
#  name               :string(255)
#  description        :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  category_id        :uuid
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  date               :datetime
#  active             :boolean          default(TRUE)
#  address            :string(255)
#  postcode           :string(255)
#  featured           :boolean          default(FALSE)
#  city               :string(255)
#  created_by_id      :integer
#  end_date           :datetime
#

class Event < ActiveRecord::Base

  has_attached_file    :photo, :styles => { :medium => "300x300#", :thumb => "200x200#", :tiny_pic => "70x70#" }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  belongs_to  :category
  has_many    :tickets
  belongs_to  :created_by, :class_name => 'User'
  validates   :category_id, :presence => true
  
  def min_price
    if self.tickets.length>0
      self.tickets.min_by { |ticket| ticket.price }.price.to_s
    else
      "0"
    end
  end
  
  def available_tickets
    if self.tickets.length>0
      self.tickets.select { |ticket| ticket.available }.count.to_s
    else
      "0"
    end
  end

end
