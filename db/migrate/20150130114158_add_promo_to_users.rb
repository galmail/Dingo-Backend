class AddPromoToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :promo, :string
    add_column  :users, :promo_used, :boolean, default: false
  end
end
