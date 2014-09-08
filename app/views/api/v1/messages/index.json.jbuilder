json.ignore_nil!
json.messages @messages do |msg|
  json.id msg.id
  json.sender_id msg.sender.id
  json.sender_name msg.sender.name
  json.sender_avatar msg.sender.photo_url
  json.receiver_id msg.receiver_id
  json.content msg.content
  json.datetime msg.created_at
end