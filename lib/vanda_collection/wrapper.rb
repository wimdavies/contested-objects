require_relative "client"
require "ostruct"

module VandaCollection
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
