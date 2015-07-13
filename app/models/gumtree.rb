# == Schema Information
#
# Table name: gumtrees
#
#  id             :integer          not null, primary key
#  link           :string
#  title          :string
#  description    :string
#  price          :string
#  identification :string
#  published      :string
#  mail_sent      :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Gumtree < ActiveRecord::Base
  validates :identification, uniqueness: true
end
