class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :tittle, null: false, default: "Package Tittle"
      t.text :description, null:false, default: "Package description"
      t.float :src_lat, null: false
      t.float :src_lon, null:false
      t.float :dest_lat,  null: false
      t.float :dest_lon,  null: false
      t.boolean :delivered, null: false, default: false
      t.references  :user

      t.timestamps
    end
  end
end
