ActiveAdmin.register Truck do

  controller do
    def new
      @truck = Truck.new(vendor_id: params[:vendor_id])
      render :new
    end
  end

end
