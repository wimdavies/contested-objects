require "httparty"
require "active_support"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"

class VandaClient
  include HTTParty
  base_uri "https://api.vam.ac.uk/v2"
  default_timeout 10

  def self.retrieve_single_object_record(system_number)
    response = self.get("/museumobject/#{system_number}")
    JSON.parse(response.parsed_response.deep_transform_keys(&:underscore).to_json, object_class: OpenStruct)
  end
end
