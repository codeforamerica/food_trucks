class Location < ActiveRecord::Base

  # ASSOCIATIONS

  has_many :time_slots, dependent: :destroy
  has_many :vendors, through: :time_slots

  # VALIDATIONS

  validates :address, presence: true

  # ATTRIBUTES

  #attr_accessor :current_vendor_ids
  attr_accessible :address, :name, :latitude, :longitude, :meter_id, :current_vendor_id, :truck_limit
  geocoded_by :address

  # CALLBACKS

  after_validation :geocode, if: lambda {|l| l.address_changed? }

  # CLASS METHODS
  def self.reset_current_vendors!
    TimeSlot.update_all(checked_in: false)
  end

  def after_initialize 
    fix_current_vendor_ids
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
    current_vendor_id = []
    self.time_slots.current.find(:all, :conditions => {:checked_in => true}).each do |t| 
      current_vendor_id << t.vendor_id
    end
    current_vendor_id = nil if current_vendor_id.empty?

#    time_slots = self.time_slots.current
#    time_slots.each do |t|
#      if t.checked_in == true
#        current_vendor_id.push(t.vendor_id)
#      end
#    end
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
        current_vendor_id: current_vendor_id,
      }
    }
  end

end
