class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :allow_dingo_emails, :boolean, default: true
    add_column  :users, :allow_push_notifications, :boolean, default: true
    add_column  :users, :fb_id, :string
  end
end
