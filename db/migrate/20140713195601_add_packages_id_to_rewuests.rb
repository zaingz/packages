class AddPackagesIdToRewuests < ActiveRecord::Migration
  def change
    add_column :requests, :package_id, :integer
  end
end
