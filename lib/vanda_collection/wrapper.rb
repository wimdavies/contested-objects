require_relative "client"
require "ostruct"
require "active_support"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"

module VandaCollection
  class Wrapper
    def self.find_by_system_number(system_number)
      response = VandaCollection::Client.retrieve_single_object_record(system_number)

      # if response.success?
        parse_single_object_record(response)
      # else
        # current plan is to return nil for status code other than 200 OK
        # nil
      # end
    # rescue
    #   # error handling goes here
    end

    private_class_method def self.parse_single_object_record(response)
      JSON.parse(
        response.deep_transform_keys(&:underscore).to_json,
        object_class: OpenStruct
      )
    end
  end
end
