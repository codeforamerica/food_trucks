namespace :tickets do

  desc "Pulls tickets from Parkeon API"
  task pull: :environment do
    Ticket.pull
  end

end
