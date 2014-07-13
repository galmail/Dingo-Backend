ActiveAdmin.register Device do
  config.filters = false
  permit_params :id, :brand, :model, :os, :uid, :mobile_number, :app_version, :user_id 
  
end
