json.ignore_nil!
json.tickets @tickets do |ticket|
  json.id ticket.id
  json.event_id ticket.event_id
  json.event_name ticket.event.name
  json.event_date ticket.event.date
  json.event_address ticket.event.address
  json.event_city ticket.event.city
  json.user_id ticket.user_id
  json.user_name ticket.user.name
  json.user_email ticket.user.inbox_email
  json.user_photo ticket.user.photo_url
  json.user_facebook_id ticket.user.fb_id
  json.price ticket.price
  json.available ticket.available
  json.seat_type ticket.seat_type
  json.description ticket.description
  json.delivery_options ticket.delivery_options
  json.payment_options ticket.payment_options
  json.number_of_tickets ticket.number_of_tickets
  json.number_of_tickets_sold ticket.number_of_tickets_sold
  json.face_value_per_ticket ticket.face_value_per_ticket
  json.ticket_type ticket.ticket_type
  json.number_of_offers ticket.offers.count
  json.photo1_thumb ticket.photo1(:thumb) if ticket.photo1.present?
  json.photo1_large ticket.photo1(:large) if ticket.photo1.present?
  json.photo2_thumb ticket.photo2(:thumb) if ticket.photo2.present?
  json.photo2_large ticket.photo2(:large) if ticket.photo2.present?
  json.photo3_thumb ticket.photo3(:thumb) if ticket.photo3.present?
  json.photo3_large ticket.photo3(:large) if ticket.photo3.present?
end
