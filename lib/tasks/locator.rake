namespace :locator do
  desc "Updates location from tickets"
  task perform: :environment do
    Locator.perform
  end
end
