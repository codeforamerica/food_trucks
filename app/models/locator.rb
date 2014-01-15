class Locator

  def self.perform
    new.perform
  end

  def perform
    Location.reset_current_vendors!

#t = Parkeon::Ticket.new(
# plate: "TEST2",
# unique_id: 752156,
# user_type: 1,
# utc_end_time: Time.now + 20000,
# utc_start_time: Time.now,
# zone: 1)
    #tickets << t

#<Parkeon::Ticket:0x00000005d2d138
# @plate="TEST2",
# @unique_id=752156,
# @user_type=1,
# @utc_end_time=Tue, 14 Jan 2014 22:32:13 +0000,
# @utc_start_time=Tue, 14 Jan 2014 21:32:13 +0000,
# @zone=1>



    tickets.each do |ticket|
#      require 'pp'
#      puts " ====================== Ticket ======================="
#	pp ticket
	
      location, vendor = ticket.location, ticket.vendor
#	puts "Location: #{location}, Vendor: #{pp vendor}"
      if location && vendor
#	puts "Updating location #{location} with Vendor #{vendor.name} and id #{vendor.id}"
	time_slots = location.time_slots.current
#	puts "Time slots ===============================================\n"
#	pp time_slots
        time_slot = location.time_slots.current.find_by_vendor_id(vendor.id)

#	puts "Data ================================================\n"
#	puts "Lcoation"
#	pp location
#	puts "Vendor"
#	pp vendor
#	puts "time slot"
#	pp time_slot
#	puts "Data ================================================\n"
	if time_slot
#          puts "Updating time slots."
          time_slot.update_attributes(checked_in: true)
        end
      end
    end

    return tickets
  end

  private

  def tickets
    @tickets ||= Ticket.where("(start_at <= ?) AND (finish_at >= ?)", Time.now, Time.now)
  end

end
