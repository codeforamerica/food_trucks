class Api::CalendarController < Api::ApplicationController

  def locations
    @location = Location.find(params[:location_id], include: :time_slots)
    respond_to do |format|
      format.ics do
        render text: convert_to_ics(@location.time_slots)
      end
    end
  end


  def time_slots
    @time_slots = TimeSlot.all
    respond_to do |format|
      format.ics do
        render text: convert_to_ics(@time_slots)
      end
    end
  end

  private

  def convert_to_ics(collection)
    Icalendar::Calendar.new.tap do |calendar|
      collection.each do |resource|
        calendar.add resource.to_ical_event
      end
    end.to_ical
  end

end
