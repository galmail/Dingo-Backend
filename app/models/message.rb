# == Schema Information
#
# Table name: messages
#
#  id              :uuid             not null, primary key
#  sender_id       :integer
#  receiver_id     :integer
#  content         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  from_dingo      :boolean          default(FALSE)
#  new_offer       :boolean          default(FALSE)
#  visible         :boolean          default(TRUE)
#  ticket_id       :uuid
#  offer_id        :uuid
#  read            :boolean          default(FALSE)
#  conversation_id :string(255)
#

class Message < ActiveRecord::Base
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :receiver, :class_name => 'User'
  belongs_to  :ticket
  belongs_to  :offer
  
  validates_presence_of :sender
  validates_presence_of :receiver
  validates_presence_of :content
  
  before_save   :save_conversation_id
  after_create  :notify
  
  def save_conversation_id
    id_part1 = 0
    id_part2 = 0
    if self.sender.id < self.receiver.id
      id_part1 = self.sender.id
      id_part2 = self.receiver.id
    else
      id_part2 = self.sender.id
      id_part1 = self.receiver.id
    end
    self.conversation_id = "#{self.ticket_id}-#{id_part1}-#{id_part2}"
  end
  
  def notify
    msg = "#{self.sender.name}: #{self.content}"
    if self.from_dingo
      msg = "#{self.content}"
    end
    
    msg = msg[0,30] << '...' unless msg.length < 30
    
    User.find(self.receiver_id).devices.each { |device|
      if device.brand.downcase.index('apple')
        #puts "Sending Apple Push to #{self.receiver.name} with msg: #{msg}"
        APNS.send_notification(device.uid, :alert => msg, :badge => self.receiver.num_unread_messages, :sound => 'default'
        # :other => {
          # :sender_id => self.sender_id,
          # :sender_fb_id => self.sender.fb_id,
          # :ticket_id => self.ticket_id,
          # :offer_id => self.offer_id,
          # :from_dingo => self.from_dingo,
          # :new_offer => self.new_offer
        # }
        )
      elsif device.brand.downcase.index('android')
        #puts "Sending Android Push to #{self.receiver.name} with msg: #{msg}"
        data = {
          :message => msg,
          :title => 'New Message from Dingo!',
          :conversation_id => self.conversation_id
          #:badge => self.receiver.num_unread_messages,
          #:alert => msg,
          #:sound => 'default',
          
          # :other => {
            # :sender_id => self.sender_id,
            # :sender_fb_id => self.sender.fb_id,
            # :ticket_id => self.ticket_id,
            # :offer_id => self.offer_id,
            # :new_offer => self.new_offer,
            # :from_dingo => self.from_dingo
          # }
        }
        GCM.send_notification([device.uid],data)
      end
    }
    return true
  end
  
  def sender_photo
    if self.from_dingo
      Settings.DINGO_LOGO
    else
      self.sender.photo_url
    end
  end
  
  def get_event_name
    if self.ticket
      return self.ticket.event.name
    else
      return ''
    end
  end
  
  def get_peer(current_user_id)
    if self.sender.id == current_user_id
      return self.receiver
    else
      return self.sender
    end
  end
  
end
