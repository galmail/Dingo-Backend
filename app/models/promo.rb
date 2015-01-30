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
end
