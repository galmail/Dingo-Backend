ActiveAdmin.register Event do
  config.filters = false
  permit_params :name, :description
  
end
