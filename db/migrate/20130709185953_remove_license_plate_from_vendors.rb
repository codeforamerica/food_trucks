class RemoveLicensePlateFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :license_plate
  end
end
