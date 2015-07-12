class CreateGumtrees < ActiveRecord::Migration
  def change
    create_table :gumtrees do |t|
      t.string  :link
      t.string  :title
      t.string  :description
      t.string  :price
      t.string  :identification
      t.string  :published
      t.boolean :mail_sent, default: false
      t.timestamps null: false
    end
  end
end
