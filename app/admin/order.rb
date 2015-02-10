ActiveAdmin.register Order do

  
  permit_params :sender_id, :receiver_id, :ticket_id, :promo_id, :num_tickets, :amount, :status, :buyers_note, :delivery_options
  
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
  
  member_action :dispute do
    order = Order.find(params[:id])
    order.open_dispute
    flash[:notice] = "Order is now under Dispute!"
    redirect_to :action => :show
  end
  
  member_action :release do
    order = Order.find(params[:id])
    result = order.release_payment(true)
    flash[:notice] = "The order status is now completed!"
    redirect_to :action => :show
  end
  
  member_action :refund do
    order = Order.find(params[:id])
    flash[:error] = "Not implemented yet"
    # result = order.refund_payment
    # if result.success?
      # flash[:notice] = "The payment was refunded back to the buyer!"
    # else
      # flash[:error] = result.error[0].message
    # end
    redirect_to :action => :show
  end
  
  action_item :only => :show do
    link_to 'Dispute', :controller => 'orders', :action => 'dispute'
  end
  
  action_item :only => :show do
    link_to 'Release', :controller => 'orders', :action => 'release'
  end
  
  action_item :only => :show do
    link_to 'Refund', :controller => 'orders', :action => 'refund'
  end
  
end
