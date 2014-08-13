class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards, id: :uuid do |t|
      t.references  :user
      t.string      :paypal_card_id
      t.string      :name_on_card
      t.string      :card_type
      t.string      :issuer
      t.integer     :last_4_digits
      t.boolean     :active, default: true
      t.timestamps
    end
  end
end
