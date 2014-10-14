# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string(255)      default(""), not null
#  encrypted_password       :string(255)      default(""), not null
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  authentication_token     :string(255)
#  name                     :string(255)
#  date_of_birth            :date
#  city                     :string(255)
#  photo_url                :string(255)
#  surname                  :string(255)
#  banned                   :boolean          default(FALSE)
#  allow_dingo_emails       :boolean          default(TRUE)
#  allow_push_notifications :boolean          default(TRUE)
#  fb_id                    :string(255)
#  paypal_account           :string(255)
#

class User < ActiveRecord::Base
  acts_as_token_authenticatable
  has_many  :devices, :dependent => :delete_all
  has_many  :tickets, :dependent => :delete_all
  has_many  :creditcards, :dependent => :delete_all
  
  has_and_belongs_to_many(:blocked_users,
    :class_name => 'User',
    :join_table => "user_blockings",
    :foreign_key => "blocking_user_id",
    :association_foreign_key => "blocked_user_id")
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:lockable
         
 
  after_save :validate_user
  
  # Validate if user is still active
  def validate_user
    if self.banned and !self.authentication_token.include?('_banned')
      banned_auth_token = self.authentication_token[0..self.authentication_token.length-7] << '_banned'
      self.update_attribute(:authentication_token, banned_auth_token)
      # also ban his devices
      self.devices.each { |device|
        device.update_attribute(:banned,true)
      }
    elsif !self.banned and self.authentication_token.include?('_banned')
      # unban user
      unbanned_auth_token = self.authentication_token[0..self.authentication_token.length-7] << rand(36**7).to_s(36)
      self.update_attribute(:authentication_token, unbanned_auth_token)
      # also unban his devices
      self.devices.each { |device|
        device.update_attribute(:banned,false)
      }
    end
  end
         
end
