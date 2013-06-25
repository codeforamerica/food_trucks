class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.datetime :start_at
      t.datetime :finish_at
      t.integer  :vendor_id
      t.integer  :location_id
      t.timestamps
    end
  end
end
