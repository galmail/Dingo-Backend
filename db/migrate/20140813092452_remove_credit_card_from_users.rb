class RemoveCreditCardFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :credit_card_id
  end
end
