class AddSrcAddressToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :src_address, :string
  end
end
