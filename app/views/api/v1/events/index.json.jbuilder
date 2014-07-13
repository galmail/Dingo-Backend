json.events @events do |event|
  json.category_id event.category_id unless event.category_id.nil?
  json.name event.name
  json.description event.description
  json.thumb event.photo(:thumb) if event.photo.present?
end