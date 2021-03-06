class AddFieldsToMessages < ActiveRecord::Migration
  def change
    add_column  :messages, :from_dingo, :boolean, default: false
    add_column  :messages, :new_offer, :boolean, default: false
    add_column  :messages, :visible, :boolean, default: true
    change_table :messages do |t|
      t.uuid    :ticket_id
    end
    add_index :messages, :ticket_id
  end
end
