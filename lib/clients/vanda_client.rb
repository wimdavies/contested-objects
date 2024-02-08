require "httparty"

class VandaClient
  include HTTParty
  base_uri "https://api.vam.ac.uk/v2"

  def self.retrieve_object_record(system_number)
    self.get("/museumobject/#{system_number}")
  end
end
