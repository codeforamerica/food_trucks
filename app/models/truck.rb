class Truck < ActiveRecord::Base

  # ASSOCIATIONS

  belongs_to :vendor

  # ATTRIBUTES

  attr_accessible :license_plate, :vendor_id

end
