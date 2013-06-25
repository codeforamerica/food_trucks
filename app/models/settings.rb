class Settings

  def self.parkeon_endpoint
    ENV["PARKEON_ENDPOINT"]
  end

  def self.parkeon_requester
    ENV["PARKEON_REQUESTER"]
  end

  def self.parkeon_version
    ENV["PARKEON_VERSION"]
  end

  def self.parkeon_service
    ENV["PARKEON_SERVICE"]
  end

end
