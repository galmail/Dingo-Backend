ActiveAdmin.register User do
  config.filters = false
  permit_params :email, :password, :name, :surname, :date_of_birth, :city, :photo_url, :allow_dingo_emails, :allow_push_notifications, :fb_id, :banned, :paypal_account
  
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
      f.input :surname
      f.input :date_of_birth
      f.input :city
      f.input :photo_url
    end
    
    f.inputs "Accounts" do
      f.input :paypal_account
      f.input :fb_id
    end
    
    f.inputs "Preferences" do
      f.input :allow_dingo_emails
      f.input :allow_push_notifications
    end
    
    f.inputs "Manage User" do
      f.input :banned
    end
    f.actions
  end
  
end
