class Location < ActiveRecord::Base

  # ASSOCIATIONS

  has_many :time_slots, dependent: :destroy
  has_many :vendors, through: :time_slots

  # VALIDATIONS

  validates :address, presence: true

  # ATTRIBUTES

  attr_accessible :address, :name, :latitude, :longitude, :meter_id, :current_vendor_id
  geocoded_by :address

  # CALLBACKS

  after_validation :geocode, if: lambda {|l| l.address_changed? }

  # CLASS METHODS

  def self.reset_current_vendors!
    Location.update_all(current_vendor_id: nil)
  end

  # INSTANCE METHODS

  def current_time_slot
    time_slots.current.first
  end

  def current_scheduled_vendor
    current_time_slot.try(:vendor)
  end

  def currently_scheduled_by?(vendor)
    current_scheduled_vendor == vendor
  end

  def to_s
    address
  end

  def to_geojson
    { 
      id: id,
      type: "Feature",
      geometry: {
        type: "Point" ,
        coordinates: [ longitude, latitude ]
      },
      properties: {
        name: name,
        address: address,
        current_vendor_id: current_vendor_id
      }
    }
  end

end
