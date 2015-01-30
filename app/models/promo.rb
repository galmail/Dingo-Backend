# == Schema Information
#
# Table name: promos
#
#  id              :uuid             not null, primary key
#  name            :string(255)
#  description     :string(255)
#  expiry_date     :datetime
#  active          :boolean          default(TRUE)
#  commission_free :boolean          default(FALSE)
#  discount        :integer          default(0)
#  created_at      :datetime
#  updated_at      :datetime
#  code            :string(255)
#

class Promo < ActiveRecord::Base
  
  def calculate_discount(amount)
    discount = 0
    if self.commission_free
      discount += amount*0.1
    end
    if self.discount>0
      discount += self.discount
    end
    return discount
  end
  
  
end
