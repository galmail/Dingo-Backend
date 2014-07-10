ActiveAdmin.register Category do
  config.filters = false
  
  permit_params :name
  
end
