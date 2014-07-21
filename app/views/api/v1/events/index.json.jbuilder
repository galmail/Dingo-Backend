json.ignore_nil!
json.events @events do |event|
  json.id event.id
  json.name event.name
  json.description event.description
  json.category_id event.category.id
  json.date event.date
  json.featured event.featured
  json.thumb event.photo(:thumb) if event.photo.present?
end