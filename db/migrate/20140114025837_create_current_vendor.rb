class CreateCurrentVendor < ActiveRecord::Migration
  def up
    create_table(:current_vendors) do |t|
      t.integer :location_id
      t.integer :vendor_id
    end
  end

  def down
    drop_table(:current_vendors)
  end
end
