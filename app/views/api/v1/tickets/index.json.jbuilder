json.ignore_nil!
json.tickets @tickets do |ticket|
  json.id ticket.id
  json.event_id ticket.event_id
  json.user_id ticket.user_id
  json.user_name ticket.user.name
  json.user_photo ticket.user.photo_url
  json.price ticket.price
  json.seat_type ticket.seat_type
  json.description ticket.description
  json.delivery_options ticket.delivery_options
  json.payment_options ticket.payment_options
  json.number_of_tickets ticket.number_of_tickets
  json.face_value_per_ticket ticket.face_value_per_ticket
  json.ticket_type ticket.ticket_type
  json.number_of_offers ticket.offers.count
  json.photo1_thumb ticket.photo1(:thumb) if ticket.photo1.present?
  json.photo1_large ticket.photo1(:large) if ticket.photo1.present?
  json.photo2_thumb ticket.photo1(:thumb) if ticket.photo2.present?
  json.photo2_large ticket.photo1(:large) if ticket.photo2.present?
  json.photo3_thumb ticket.photo1(:thumb) if ticket.photo3.present?
  json.photo3_large ticket.photo1(:large) if ticket.photo3.present?
end
