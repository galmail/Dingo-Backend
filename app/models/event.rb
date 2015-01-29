# == Schema Information
#
# Table name: events
#
#  id                        :uuid             not null, primary key
#  name                      :string(255)
#  description               :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  category_id               :uuid
#  photo_file_name           :string(255)
#  photo_content_type        :string(255)
#  photo_file_size           :integer
#  photo_updated_at          :datetime
#  date                      :datetime
#  active                    :boolean          default(TRUE)
#  address                   :string(255)
#  postcode                  :string(255)
#  featured                  :boolean          default(FALSE)
#  city                      :string(255)
#  created_by_id             :integer
#  end_date                  :datetime
#  test                      :boolean          default(FALSE)
#  for_sale                  :boolean          default(FALSE)
#  min_price                 :decimal(8, 2)    default(0.0)
#  available_tickets         :integer          default(0)
#  venue_id                  :uuid
#  primary_ticket_seller_url :string(255)
#

class Event < ActiveRecord::Base

  has_attached_file    :photo, :styles => { :medium => "300x300#", :thumb => "200x200#", :tiny_pic => "70x70#" }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  belongs_to  :venue
  belongs_to  :category
  has_many    :tickets
  belongs_to  :created_by, :class_name => 'User'
  
  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :date
  validates_attachment_presence :photo
  
  after_save  :check_for_primary_market_tickets
  
  def calculate_min_price
    price = 0
    current_tickets = self.tickets.select { |ticket| ticket.available? }
    if current_tickets.length>0
      price = current_tickets.min_by{ |ticket| ticket.price }.price
    end
    price.to_s
  end
  
  
  def calculate_available_tickets
    total = 0
    current_tickets = self.tickets.select { |ticket| ticket.available? }
    if current_tickets.length>0
      total = current_tickets.inject(0) { |sum,ticket| sum + ticket.number_of_tickets }
    end
    return total
  end
  
  def check_for_primary_market_tickets
    if !self.primary_ticket_seller_url.nil? and self.primary_ticket_seller_url.length>0 and !self.for_sale
      self.for_sale = true
      self.save
    elsif (self.primary_ticket_seller_url.nil? or self.primary_ticket_seller_url.length==0) and self.for_sale and self.calculate_available_tickets==0     
      self.for_sale = false
      self.save
    end
  end

end
