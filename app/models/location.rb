class Location < ActiveRecord::Base

  # ASSOCIATIONS

  has_many :time_slots
  has_many :vendors, through: :time_slots

  # VALIDATIONS

  validates :address, presence: true

  # ATTRIBUTES

  attr_accessible :address, :parkeon_id
  geocoded_by :address

  # CALLBACKS

  after_validation :geocode, if: lambda {|l| l.address_changed? }

  # INSTANCE METHODS

  def to_s
    address
  end

end
