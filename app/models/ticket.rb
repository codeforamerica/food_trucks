class Ticket < ActiveRecord::Base

  # CONSTANTS

  PARKEON_MAPPING = {
    unique_id:      :id,
    zone:           :meter_id,
    user_type:      :user_type,
    plate:          :license_plate,
    utc_start_time: :start_at,
    utc_end_time:   :finish_at
  }

  # VALIDATIONS

  validates :id, uniqueness: true, presence: true

  # ATTRIBUTES

  attr_accessible :id, :meter_id, :user_type,
    :license_plate, :start_at, :finish_at

  # CLASS METHODS

  def self.from_parkeon_ticket(ticket)
    (new).tap do |t|
      PARKEON_MAPPING.each do |attr_a, attr_b|
        t.send("#{attr_b}=", ticket.send(attr_a))
      end
    end.save
  end

  def self.pull
    Parkeon::Ticket.all.map do |ticket|
	#require 'pp'
	# pp ticket
      from_parkeon_ticket(ticket)
    end
  end

  # INSTANCE METHODS

  def vendor
    Vendor.joins(:trucks).where("trucks.license_plate = ?", license_plate).first
  end

  def location
    Location.where("meter_id = ?", meter_id).first
  end

end
