class AddPromoToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.uuid  :promo_id
    end
  end
end
