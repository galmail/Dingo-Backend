json.ignore_nil!
json.tickets @tickets do |ticket|
  json.id ticket.id
  json.event_id ticket.event_id
  json.price ticket.price
  json.seat_type ticket.seat_type
  json.description ticket.description
end