class AddConversationIdToMessages < ActiveRecord::Migration
  def change
    add_column  :messages, :conversation_id, :string
  end
end
