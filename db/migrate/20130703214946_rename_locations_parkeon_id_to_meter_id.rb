class RenameLocationsParkeonIdToMeterId < ActiveRecord::Migration
  def change
    rename_column :locations, :parkeon_id, :meter_id
  end
end
