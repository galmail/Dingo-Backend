class Api::V1::PromosController < Api::BaseController
    
    # Get Promo Discount
    def get_discount
      discount = 0
      promos = Promo.where(:code => current_user.promo, :active => true)
      if promos.length>0 and !current_user.promo_used
        discount = promos.first.calculate_discount(params[:amount].to_f)
      end
      render :json => { :promo_id => promos.first.id, :discount => discount }
    end
    
end