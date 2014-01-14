class Locator

  def self.perform
    new.perform
  end

  def perform
    Location.reset_current_vendors!

    tickets.each do |ticket|
      location, vendor = ticket.location, ticket.vendor
	require 'pp'
	puts "Location: #{location}, Vendor: #{pp vendor}"
      if location && vendor
	puts "Updating location #{location} with Vendor #{vendor.name} and id #{vendor.id}"
        location.update_attributes(current_vendor_id: vendor.id)
      end
    end

    return tickets
  end

  private

  def tickets
    @tickets ||= Ticket.where("(start_at <= ?) AND (finish_at >= ?)", Time.now, Time.now)
  end

end
