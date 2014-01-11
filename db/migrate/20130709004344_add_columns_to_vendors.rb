class AddColumnsToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :cuisine, :string
    add_column :vendors, :contact_name, :string
    add_column :vendors, :phone, :string
    add_column :vendors, :email, :string
    add_column :vendors, :website, :string
#    add_column :vendors, :license_plate, :string
  end
end
