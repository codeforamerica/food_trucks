ActiveAdmin.register TimeSlot do

  menu false
  controller.send(:belongs_to, :location, :vendor, polymorphic: true)

  controller do

    def show
      if params.include?(:location_id) || params.include?(:vendor_id)
        super
      else
        @time_slot = TimeSlot.find(params[:id])
        if @time_slot.location_id
          redirect_to admin_location_time_slot_path(
            @time_slot.attributes.extract!("location_id", "id")
          )
        elsif @time_slot.vendor_id
          redirect_to admin_vendor_time_slot_path(
            @time_slot.attributes.extract!("vendor_id", "id")
          )
        else
          raise "Invalid TimeSlot"
        end
      end
    end

    def destroy
      @time_slot = TimeSlot.find(params[:id])
      @time_slot.destroy
      redirect_to :back
    end

  end

  csv do
    column :start_at
    column :finish_at
    column :location_name
    column :vendor_name
  end

  scope :current
  scope :upcoming
  scope :expired

  index do
    column :vendor
    column :location
    column :start_at
    column :finish_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :vendor,    as: :select
      f.input :location,  as: :select
      f.input :start_at,  as: :datetime, ampm: true
      f.input :finish_at, as: :datetime, ampm: true
    end
    f.buttons
  end

end
