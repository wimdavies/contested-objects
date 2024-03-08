require "httparty"
require "active_support"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"
require "ostruct"

module VandaCollection
  class Client
    include HTTParty
    base_uri "https://api.vam.ac.uk/v2"
    default_timeout 5
    SYSTEM_NUMBER_FORMAT = /O\d+/
  
    def self.retrieve_single_object_record(system_number)
      raise ArgumentError.new("System number must be in valid format") unless system_number =~ SYSTEM_NUMBER_FORMAT
  
      self.get("/museumobject/#{system_number}")
    end
  end

  class Wrapper
    def self.find_by_system_number(system_number)
      response = VandaCollection::Client.retrieve_single_object_record(system_number)

      if response.success?
        JSON.parse(response.deep_transform_keys(&:underscore).to_json, object_class: OpenStruct)
      else
        # current plan is to return nil for status code other than 200 OK
        nil
      end
    # rescue
    #   # error handling goes here
    end
  end
end
