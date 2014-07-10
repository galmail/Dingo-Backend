ActiveAdmin.register User do
  config.filters = false
  index do
    column :email
    column :created_at
    column :updated_at
    column :authentication_token
    actions
  end
  
  form do |f|
    f.inputs "Authentication" do
      f.input :email
      f.input :password
    end
    # f.inputs "Details" do
      # f.input :name
    # end
    f.actions
  end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :password
  #
  # or
  #
  #permit_params do
   #permitted = [:permitted, :attributes]
   #permitted << :other if resource.something?
   #permitted
  #end
  
end
