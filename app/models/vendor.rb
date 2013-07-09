class Vendor < ActiveRecord::Base
  # ASSOCIATIONS

  has_many :time_slots
  has_many :locations, through: :time_slots

  # ATTRIBUTES

  attr_accessible :name, :license_plate, :contact_name, :phone, :email, :cuisine, :website

end
