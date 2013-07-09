class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
      t.string  :license_plate
      t.integer :vendor_id
      t.timestamps
    end
  end
end
