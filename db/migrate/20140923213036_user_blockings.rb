class UserBlockings < ActiveRecord::Migration
  create_table "user_blockings", :force => true, :id => false do |t|
    t.integer "blocking_user_id", :null => false
    t.integer "blocked_user_id", :null => false
  end
end



