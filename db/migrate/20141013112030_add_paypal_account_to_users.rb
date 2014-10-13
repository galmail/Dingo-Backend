class AddPaypalAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_account, :string
  end
end
