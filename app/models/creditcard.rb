# == Schema Information
#
# Table name: creditcards
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  paypal_card_id :string(255)
#  name_on_card   :string(255)
#  card_type      :string(255)
#  issuer         :string(255)
#  last_4_digits  :integer
#  active         :boolean          default(TRUE)
#  created_at     :datetime
#  updated_at     :datetime
#

class Creditcard < ActiveRecord::Base
  belongs_to  :user
  
end
