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
#  test               :boolean          default(FALSE)
#

class Event < ActiveRecord::Base

  has_attached_file    :photo, :styles => { :medium => "300x300#", :thumb => "200x200#", :tiny_pic => "70x70#" }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  belongs_to  :category
  has_many    :tickets
  belongs_to  :created_by, :class_name => 'User'
  
  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :date
  validates_attachment_presence :photo
  
  def min_price
    price = 0
    current_tickets = self.tickets.select { |ticket| ticket.available? }
    if current_tickets.length>0
      price = current_tickets.min_by{ |ticket| ticket.price }.price
    end
    price.to_s
  end
  
  def available_tickets
    total = 0
    current_tickets = self.tickets.select { |ticket| ticket.available? }
    if current_tickets.length>0
      total = current_tickets.inject(0) { |sum,ticket| sum + ticket.number_of_tickets }
    end
    return total
  end

end
