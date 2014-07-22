json.ignore_nil!
json.events @events do |event|
  json.id event.id
  json.name event.name
  json.description event.description
  json.category_id event.category.id
  json.date event.date
  json.featured event.featured
  json.address event.address
  json.postcode event.postcode
  json.city event.city
  json.min_price "10.5"
  json.available_tickets "10"
  json.thumb event.photo(:thumb) if event.photo.present?
end