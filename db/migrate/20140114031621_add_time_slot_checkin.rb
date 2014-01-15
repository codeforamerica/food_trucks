class AddTimeSlotCheckin < ActiveRecord::Migration
  def up
    add_column :time_slots, :checked_in, :boolean, default: false
  end

  def down
  end
end
