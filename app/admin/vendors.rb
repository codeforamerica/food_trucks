ActiveAdmin.register Vendor do

  action_item only: :show do
    link_to "Create Time Slot", new_admin_vendor_time_slot_path(vendor)
  end

  action_item only: :show do
    link_to "Create Truck", new_admin_vendor_truck_path(vendor)
  end

  show do
    render "admin/time_slots/index", time_slots: vendor.time_slots.page(params[:page]).per(10), context: self
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
      vendor.trucks.map {|truck| li { link_to truck.license_plate, admin_vendor_truck_path(truck) } }.join("")
    end
  end

end
