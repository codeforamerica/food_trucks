ActiveAdmin.register TimeSlot do

  menu false
  controller.send(:belongs_to, :location, :vendor, polymorphic: true)

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
