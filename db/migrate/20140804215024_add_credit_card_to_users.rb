class AddCreditCardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit_card_id, :string
  end
end
