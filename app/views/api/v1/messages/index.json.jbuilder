json.ignore_nil!
json.messages @messages do |msg|
  json.id msg.id
  json.sender_id msg.sender_id
  json.receiver_id msg.receiver_id
  json.content msg.content
  json.datetime msg.created_at
end