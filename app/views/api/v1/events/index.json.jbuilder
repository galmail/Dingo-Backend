json.events @events do |event|
  json.name event.name
  json.description event.description
  json.category event.category.name unless event.category.nil?
end