class AddBusinessLicenseNoToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :business_license_number, :string
  end
end
