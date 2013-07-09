class AddCurrentVendorIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :current_vendor_id, :integer
  end
end
