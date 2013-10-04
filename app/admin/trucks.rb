ActiveAdmin.register Truck do

  controller do
    def new
      @truck = Truck.new(vendor_id: params[:vendor_id])
      render :new
    end
  end

  index do
    column :id
    column("Vendor Name") {|truck| truck.vendor_name }
    column :license_plate
    column :created_at
    column :updated_at
    default_actions
  end

end
