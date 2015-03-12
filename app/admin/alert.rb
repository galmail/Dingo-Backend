ActiveAdmin.register Alert do

  permit_params :user_id, :event_id, :price, :active, :description
  
  
  index do
    column :user
    column :event
    column :created_at
    column :description
    column :active
    actions
  end
  
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
