class Truck < ActiveRecord::Base

  # ASSOCIATIONS

  belongs_to :vendor

  # ATTRIBUTES

  attr_accessible :license_plate, :vendor_id

  # INSTANCE METHODS

  def to_s
    license_plate
  end

  def vendor_name
    vendor.try(:name)
  end

end
