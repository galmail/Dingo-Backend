class AddOfferToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.uuid    :offer_id
    end
    add_index :messages, :offer_id
  end
end
