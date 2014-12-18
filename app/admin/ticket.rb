ActiveAdmin.register Ticket do
  config.filters = false
  permit_params :price, :seat_type, :ticket_type, :description, :photo1, :photo2, :photo3, :event_id, :user_id, :delivery_options, :payment_options, :number_of_tickets, :face_value_per_ticket, :available
  
  index do
    column :id
    column :created_at
    column "Event" do |ticket|
      event = Event.find(ticket.event_id)
      link_to event.name, admin_event_path(ticket.event_id)
    end
    column :user
    column :price
    column :ticket_type
    column :number_of_tickets
    column :available
    actions
  end
  
  show do
    column :id
    column :created_at
    column "Event" do |ticket|
      event = Event.find(ticket.event_id)
      link_to event.name, admin_event_path(ticket.event_id)
    end
    column :user
    column :price
    column :ticket_type
    column :description
    column :number_of_tickets
    column :available
    column :photo1 do |ad|
      image_tag(ad.photo1.url(:thumb))
    end
    column :photo2 do |ad|
      image_tag(ad.photo2.url(:thumb))
    end
    column :photo3 do |ad|
      image_tag(ad.photo3.url(:thumb))
    end
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
