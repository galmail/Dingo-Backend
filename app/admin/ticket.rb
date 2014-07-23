ActiveAdmin.register Ticket do
  
  permit_params :price, :seat_type, :description, :photo1, :photo2, :photo3, :event_id, :user_id, :delivery_options, :payment_options, :number_of_tickets, :face_value_per_ticket, :available
  

  
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
