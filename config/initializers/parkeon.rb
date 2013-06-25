Parkeon::Config.configure do |config|
  config.endpoint  = Settings.parkeon_endpoint
  config.requester = Settings.parkeon_requester
  config.version   = Settings.parkeon_version
  config.service   = Settings.parkeon_service
end
