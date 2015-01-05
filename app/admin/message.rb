ActiveAdmin.register Message do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :sender_id, :receiver_id, :ticket_id, :conversation_id, :content, :from_dingo, :visible, :read
  
  
  preserve_default_filters!
  filter :conversation_id
  
  form do |f|
    f.inputs "Message Inputs" do
      f.input :sender
      f.input :receiver
      f.input :content  
    end
    f.actions
  end
   
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
