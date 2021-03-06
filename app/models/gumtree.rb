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

require 'rest-client'

class Gumtree < ActiveRecord::Base
  validates :identification, uniqueness: true
  
  def sendmail
    return false if self.mail_sent
    # call gumtree bot to send mail and mark as "sent"
    response = RestClient.get "http://52.18.108.118:3000/sendmail/#{self.identification}"
    res = JSON.parse(response)
    return (res["success"] == "true")
  end
  
end
