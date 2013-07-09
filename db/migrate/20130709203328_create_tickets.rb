class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets, id: false do |t|
      t.integer  :id
      t.string   :meter_id
      t.string   :user_type
      t.string   :license_plate
      t.datetime :start_at
      t.datetime :finish_at
    end
  end
end
