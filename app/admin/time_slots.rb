ActiveAdmin.register TimeSlot do

  menu false
  controller.send(:belongs_to, :location, :vendor, polymorphic: true)

  scope :current
  scope :upcoming
  scope :expired

  form do |f|
    f.inputs do
      f.input :vendor,    as: :select
      f.input :location,  as: :select
      f.input :start_at,  as: :just_datetime_picker
      f.input :finish_at, as: :just_datetime_picker
    end
    f.buttons
  end

end
