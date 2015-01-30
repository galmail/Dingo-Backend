class RemoveTCfromPromos < ActiveRecord::Migration
  def change
    remove_column :promos, :terms_and_conditions
  end
end
