class TimeSlot < ActiveRecord::Base

  default_scope lambda { where("finish_at >= ?", Time.now) }

  # SCOPES

  scope :upcoming, lambda { where("start_at > ?", Time.now) }
  scope :expired,  lambda { where("finish_at < ?", Time.now) }
  scope :current,  lambda { where("(start_at < ?) AND (finish_at > ?)", Time.now, Time.now) }

  # ASSOCIATIONS

  belongs_to :vendor
  belongs_to :location

  # VALIDATIONS

  validate :has_no_time_conflicts

  # ATTRIBUTES
 
  attr_accessible :location_id, :vendor_id, :start_at, :finish_at, :checked_in

  # INSTANCE METHODS

  def to_s
    "#{id}"
  end

  def available?
    vendor.nil?
  end

  def conflicts_with?(time_slot)
    [:start_at, :finish_at].any? do |method|
      has_time?(time_slot.send(method)) || time_slot.has_time?(send(method))
    end
  end

  def has_time?(time)
    ## I -think- this should allow them to share the same start and finish times.
    time > start_at && time < finish_at
    #time >= start_at && time <= finish_at
  end

  def location_name
    location.try(:name)
  end

  def vendor_name
    vendor.try(:name)
  end

  def to_ical_event
    Icalendar::Event.new.tap do |event|
      event.start       = ical_time(start_at)
      event.end         = ical_time(finish_at)
      event.summary     = "#{vendor.name} at #{location_name}"
      event.description = "#{vendor.name} - #{vendor.cuisine}"
    end
  end

  private

  def ical_time(t)
    DateTime.civil(t.year, t.month, t.day, t.hour, t.min)
  end

  def has_time_conflict?
    ## Check and see how many slots a location has
    #Rails.logger.info("running has_time_conflicts")
    truck_limit = location.truck_limit || 1
    current_trucks = 1 

#    require 'pp'
#    Rails.logger.info("Time slots: #{pp location.time_slots}")
    #location.time_slots.each do |t|  # Get only time slots whose end date > now
    location.time_slots.each do |t|  # Get only time slots whose end date > now
#	Rails.logger.info("\n\n\n===============================================================")
#	Rails.logger.info("Current trucks: #{current_trucks} and limit: #{truck_limit}")
#	Rails.logger.info("===============================================================\n\n\n")
      current_trucks += 1 if conflicts_with?(t)
      return true if current_trucks > truck_limit
    end

    return current_trucks > truck_limit 
  end

  def has_no_time_conflicts
    Rails.logger.info("running has_no_time_conflicts")
    if has_time_conflict?
      errors.add(:start_at, "Time slot conflicts with existing time slot")
      errors.add(:finish_at, "Time slot conflicts with existing time slot")
    end
  end

end
