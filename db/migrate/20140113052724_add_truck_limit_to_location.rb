class AddTruckLimitToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :truck_limit, :integer
  end
end
