class AddIndexToUserIdInRequests < ActiveRecord::Migration
  def change
    remove_index :requests, :user_id
    add_index :requests, :user_id, unique: true
  end
end
