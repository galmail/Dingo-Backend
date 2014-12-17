class AddForSaleToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :for_sale, :boolean, default: false
  end
end
