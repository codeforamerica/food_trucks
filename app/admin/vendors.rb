ActiveAdmin.register Vendor do

  config.sort_order = "name_asc"

  action_item only: :show do
    link_to "Create Time Slot", new_admin_vendor_time_slot_path(vendor)
  end

  action_item only: :show do
    link_to "Create Truck", new_admin_vendor_truck_path(vendor)
  end

  show do
    render "admin/time_slots/index", time_slots: vendor.time_slots.page(params[:page]).per(10), context: self
    br
    active_admin_comments
  end

  index do
    column :name
    column :cuisine
    column :phone
    column :email
    column :website
    column :business_license_number
    default_actions
  end

  sidebar :vendor_attributes, only: :show do
    attributes_table_for resource do
      row :name
      row :cuisine
      row :website
      row :contact_name
      row :phone
      row :email
      row :business_license_number
    end
  end

  sidebar :vendor_trucks, only: :show do
    ul do
      vendor.trucks.map {|truck| li { link_to truck.license_plate, admin_vendor_truck_path(vendor, truck) } }.join("")
    end
  end

  index do
    column :name
    column :cuisine
    column :contact_name
    column :phone
    column :email
    column :website
    default_actions
  end
end
