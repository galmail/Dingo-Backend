class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos, id: :uuid do |t|
      t.string    :name
      t.string    :description
      t.text      :terms_and_conditions
      t.datetime  :expiry_date
      t.boolean   :active,  default: true
      t.boolean   :commission_free, default: false
      t.integer   :discount, default: 0
      t.timestamps
    end
  end
end
