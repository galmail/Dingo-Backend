json.ignore_nil!
json.events @events do |event|
  json.id event.id
  json.name event.name
  json.description event.description
  json.category_id event.category.id
  json.date event.date
  json.end_date event.end_date
  json.featured event.featured
  json.address event.address
  json.postcode event.postcode
  json.city event.city
  json.min_price event.min_price
  json.available_tickets event.available_tickets
  json.thumb event.photo(:thumb) if event.photo.present?
  json.primary_ticket_seller_url event.primary_ticket_seller_url
  json.test event.test
end