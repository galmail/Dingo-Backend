json.categories @categories do |category|
  json.name category.name
  json.thumb category.photo(:thumb) if category.photo.present?
end