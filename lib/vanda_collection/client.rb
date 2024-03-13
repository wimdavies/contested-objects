require "httparty"
require "active_support"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"
require_relative "error"

module VandaCollection
  class Client
    include HTTParty
    base_uri "https://api.vam.ac.uk/v2"
    default_timeout 5
    SYSTEM_NUMBER_FORMAT = /O\d+/
  
    def self.retrieve_single_object_record(system_number)
      raise SystemNumberFormatError, "System number '#{system_number}' must be in valid format" unless system_number =~ SYSTEM_NUMBER_FORMAT
  
      response = self.get("/museumobject/#{system_number}")
      if response.success?
        response.parsed_response      
      elsif response.not_found?
        raise NotFoundError, "Client received response status code #{response.code}"
      end
    end
  end
end
