json.ignore_nil!
json.offers @offers do |offer|
  json.id offer.id
  json.sender_id offer.sender_id
  json.receiver_id offer.receiver_id
  json.num_tickets offer.num_tickets
  json.price offer.price
  json.datetime offer.created_at
  json.accepted offer.accepted
  json.rejected offer.rejected
end