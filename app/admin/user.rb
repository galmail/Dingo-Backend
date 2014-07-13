ActiveAdmin.register User do
  config.filters = false
  permit_params :email, :password, :name, :date_of_birth, :city, :photo_url
  
  index do
    column :email
    column :created_at
    column :authentication_token
    actions
  end
  
  form do |f|
    f.inputs "Authentication" do
      f.input :email
      f.input :password
    end
    f.inputs "Details" do
      f.input :name
      f.input :date_of_birth
      f.input :city
      f.input :photo_url
    end
    f.actions
  end
  
end
