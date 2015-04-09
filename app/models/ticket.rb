# == Schema Information
#
# Table name: tickets
#
#  id                     :uuid             not null, primary key
#  user_id                :integer
#  event_id               :uuid
#  price                  :decimal(8, 2)
#  seat_type              :string(255)
#  description            :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  photo1_file_name       :string(255)
#  photo1_content_type    :string(255)
#  photo1_file_size       :integer
#  photo1_updated_at      :datetime
#  photo2_file_name       :string(255)
#  photo2_content_type    :string(255)
#  photo2_file_size       :integer
#  photo2_updated_at      :datetime
#  photo3_file_name       :string(255)
#  photo3_content_type    :string(255)
#  photo3_file_size       :integer
#  photo3_updated_at      :datetime
#  delivery_options       :string(255)
#  payment_options        :string(255)
#  number_of_tickets      :integer          default("1")
#  face_value_per_ticket  :decimal(8, 2)
#  available              :boolean          default("true")
#  ticket_type            :string(255)
#  number_of_tickets_sold :integer          default("0")
#

class Ticket < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  has_many    :offers
  has_many    :messages
  
  has_attached_file    :photo1, :styles => { :thumb => "200x200#", :large => "400x400#" }
  has_attached_file    :photo2, :styles => { :thumb => "200x200#", :large => "400x400#" }
  has_attached_file    :photo3, :styles => { :thumb => "200x200#", :large => "400x400#" }
  
  validates_attachment  :photo1, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  validates_attachment  :photo2, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  validates_attachment  :photo3, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  
  validates_presence_of :user
  validates_presence_of :event
  
  after_create  :alert_buyers
  after_save    :update_event
  
  def name
    "Ticket for #{self.event.name}" unless self.event.nil?
  end
  
  def update_event
    self.event.min_price = self.event.calculate_min_price
    self.event.available_tickets = self.event.calculate_available_tickets
    self.event.for_sale = (self.event.available_tickets > 0)
    self.event.save
  end
  
  def alert_buyers
    # Get all alerts where event is this and this ticket price is less than alert's price
    alerts = Alert.where(["event_id = ? AND ? <= price AND active=?",self.event_id, self.price, true])
    if alerts.length>0
      alerts.each { |alert| alert.notify_user(self.price) }
    end
  end
  
  def sold!(num_tickets)
    self.number_of_tickets -= num_tickets
    self.number_of_tickets_sold += num_tickets
    if self.number_of_tickets==0
      self.available = false
    end
    self.save
  end
  
end
