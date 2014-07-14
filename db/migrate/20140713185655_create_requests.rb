class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references  :user
      t.text :message, default: "", null: false
      t.boolean :accepted, null: false, default: false
      t.timestamps
    end
    add_index :requests, :user_id
  end
end
