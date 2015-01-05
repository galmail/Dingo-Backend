class Api::V1::OffersController < Api::BaseController
  
  # Get Offers
  def index
    query = ""
    conditions = []
    filters = {}
    
    if !params.has_key?(:auth_token)
      query << and_query(query) << "(sender_id = ? OR receiver_id = ?)"
      conditions << current_user.id
      conditions << current_user.id
    elsif params.has_key?(:auth_token)
      query << and_query(query) << "(sender_id = ? OR receiver_id = ?)"
      user = User.find_for_authentication({:authentication_token => params[:auth_token]})
      conditions << user.id
      conditions << user.id
    end

    if params.has_key?(:sender_id)
      filters[:sender_id] = params[:sender_id]
    end

    if params.has_key?(:receiver_id)
      filters[:receiver_id] = params[:receiver_id]
    end

    @offers = Offer.where(filters).where(conditions.insert(0,query)).order('created_at DESC').limit(100)
  end

  # Send Offer
  def create
    params.require(:receiver_id)
    params.require(:ticket_id)
    params.require(:num_tickets)
    params.require(:price)
    offer_params = params.permit(:receiver_id, :ticket_id, :num_tickets, :price)

    offer = Offer.new(offer_params)
    offer.sender = current_user
    if offer.save
      offer.notify
      render :json=> offer.as_json, status: :created
    else
      render :json=> offer.errors, status: :unprocessable_entity
    end
  end
  
  # Accept/Reject Offer
  def update
    params.require(:id)
    params.require(:accept_offer)
    offer = Offer.find(params[:id])
    offer.accepted = params[:accept_offer]
    offer.rejected = !offer.accepted
    if offer.save
      offer.notify_accept_or_reject
      render :json=> offer.as_json, status: :ok
    else
      render :json=> offer.errors, status: :unprocessable_entity
    end
  end

  private

  def and_query(query)
    if query.length>0
      return " AND "
    else
      return ""
    end
  end

end