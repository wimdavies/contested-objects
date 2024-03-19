require_relative "error"
require "httparty"

module VandaCollection
  class Client
    include HTTParty
    base_uri "https://api.vam.ac.uk/v2"
    default_timeout 5
    SYSTEM_NUMBER_FORMAT = /O\d+/
  
    def self.retrieve_single_object_record(system_number)
      raise SystemNumberFormatError, "System number '#{system_number}' must be in valid format" unless system_number =~ SYSTEM_NUMBER_FORMAT
  
      response = self.get("/museumobject/#{system_number}")
      handle_response_status(response)
    rescue ClientError => error
      raise error
    rescue StandardError => error
      raise ClientError, "Client encountered an error: #{error.class}: #{error.message}"
    end

    private_class_method def self.handle_response_status(response)
      case response.code
      when 200
        response.parsed_response
      when 404
        raise NotFoundError, "Client received response status code 404"
      else
        raise ResponseStatusCodeError, "Client received response status code #{response.code}"
      end
    end
  end
end
