ActiveAdmin.register Device do
  config.filters = false
  permit_params :id, :brand, :model, :os, :uid, :mobile_number, :app_version, :user_id, :ip, :location, :banned
  
  index do
    column :user
    column :brand
    column :model
    column :os
    column :created_at
    column :banned
    actions
  end
  
end
