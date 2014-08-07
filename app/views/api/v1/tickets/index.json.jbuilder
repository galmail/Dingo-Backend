json.ignore_nil!
json.tickets @tickets do |ticket|
  json.id ticket.id
  json.event_id ticket.event_id
  json.user_id ticket.user_id
  json.price ticket.price
  json.seat_type ticket.seat_type
  json.description ticket.description
  json.delivery_options ticket.delivery_options
  json.payment_options ticket.payment_options
  json.number_of_tickets ticket.number_of_tickets
  json.face_value_per_ticket ticket.face_value_per_ticket
  json.ticket_type ticket.ticket_type
  json.photo1_thumb event.photo1(:thumb) if ticket.photo1.present?
  json.photo1_large event.photo1(:large) if ticket.photo1.present?
  json.photo2_thumb event.photo1(:thumb) if ticket.photo2.present?
  json.photo2_large event.photo1(:large) if ticket.photo2.present?
  json.photo3_thumb event.photo1(:thumb) if ticket.photo3.present?
  json.photo3_large event.photo1(:large) if ticket.photo3.present?
end
