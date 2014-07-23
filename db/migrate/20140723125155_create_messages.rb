class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, id: :uuid do |t|
      t.references  :sender
      t.references  :receiver
      t.string      :content
      t.timestamps
    end
  end
end
