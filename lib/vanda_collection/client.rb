require "httparty"
require "active_support"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"

module VandaCollection
  class Client
    include HTTParty
    base_uri "https://api.vam.ac.uk/v2"
    default_timeout 5
    SYSTEM_NUMBER_FORMAT = /O\d+/
  
    def self.retrieve_single_object_record(system_number)
      raise ArgumentError.new("System number must be in valid format") unless system_number =~ SYSTEM_NUMBER_FORMAT
  
      response = self.get("/museumobject/#{system_number}")
      response.parsed_response if response.success?
    end
  end
end
