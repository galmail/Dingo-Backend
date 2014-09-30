json.ignore_nil!
json.alerts @alerts do |alert|
  json.id alert.id
  json.event_id alert.event_id
  json.description alert.description
  json.price alert.price
end