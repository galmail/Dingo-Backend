ActiveAdmin.register Ticket do
  config.filters = false
  permit_params :price, :seat_type, :description, :photo1, :photo2, :photo3, :event_id, :user_id, :delivery_options, :payment_options, :number_of_tickets, :face_value_per_ticket, :available
  
  index do
    column :id
    column :price
    column :seat_type
    column :description
    column :event_id
    column :user_id
    column :number_of_tickets
    column :available
    column :photo1 do |ad|
      image_tag(ad.photo.url(:thumb))
    end
    column :photo2 do |ad|
      image_tag(ad.photo.url(:thumb))
    end
    column :photo3 do |ad|
      image_tag(ad.photo.url(:thumb))
    end
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
