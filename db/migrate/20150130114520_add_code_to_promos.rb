class AddCodeToPromos < ActiveRecord::Migration
  def change
    add_column  :promos, :code, :string
  end
end
