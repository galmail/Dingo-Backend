# == Schema Information
#
# Table name: venues
#
#  id             :uuid             not null, primary key
#  name           :string(255)
#  city           :string(255)
#  address        :string(255)
#  layout_map_url :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Venue < ActiveRecord::Base
  has_many  :events
  
end
