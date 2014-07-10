class User < ActiveRecord::Base
  
  acts_as_token_authenticatable
  
  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:lockable
  
end
