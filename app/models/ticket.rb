class Ticket < ActiveRecord::Base

  # CONSTANTS

  PARKEON_MAPPING = {
    id:             :id,
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
      from_parkeon_ticket(ticket)
    end
  end

end
