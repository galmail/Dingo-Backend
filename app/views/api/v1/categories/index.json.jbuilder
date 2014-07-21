json.ignore_nil!
json.categories @categories do |category|
  json.id category.id
  json.name category.name
  json.thumb category.photo(:thumb) if category.photo.present?
end