ActiveAdmin.register Location do

  action_item only: :show do
    link_to "All Time Slots", admin_location_time_slots_path(location)
  end

  action_item only: :show do
    link_to "Create Time Slot", new_admin_location_time_slot_path(location)
  end

  show do
    render "admin/time_slots/index", time_slots: apply_filters(location.time_slots), context: self
    br
    active_admin_comments
  end

  index do
    column :address
    column :latitude
    column :longitude
    column :name
    default_actions
  end

  sidebar :location_attributes, only: :show do
    attributes_table_for resource do
      row :name
      row :address
      row :latitude
      row :longitude
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :meter_id
      f.input :latitude
      f.input :longitude
    end
    f.buttons
  end

end
