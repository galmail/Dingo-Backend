# == Schema Information
#
# Table name: devices
#
#  id            :uuid             not null, primary key
#  user_id       :integer
#  brand         :string(255)
#  model         :string(255)
#  os            :string(255)
#  app_version   :string(255)
#  uid           :string(255)
#  mobile_number :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  ip            :string(255)
#  location      :string(255)
#  banned        :boolean          default(FALSE)
#

class Device < ActiveRecord::Base
  belongs_to  :user
  validates   :user_id, :uid, presence: true
  validates   :uid, uniqueness: true
  
  after_save :validate_device
  
  def validate_device
    if self.banned and !self.user.banned
      self.user.update_attribute(:banned,true)
    end
  end
  
end
