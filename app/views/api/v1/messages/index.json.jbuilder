json.ignore_nil!
json.messages @messages do |msg|
  json.id msg.id
  json.sender_id msg.sender.id
  json.sender_name msg.sender.name
  json.sender_avatar msg.sender_photo
  json.receiver_id msg.receiver_id
  json.content msg.content
  json.ticket_id msg.ticket_id
  json.offer_id msg.offer_id
  json.from_dingo msg.from_dingo
  json.new_offer msg.new_offer
  json.datetime msg.created_at
end