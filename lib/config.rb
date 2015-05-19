require 'lib/constants'
require 'lib/serializer'

module Tundra
  module Config
    extend self

    # set location in config file 
    def set_location(location)
      @settings.location ||= location
    end

    # set temperature unit in config file
    # (e.g. F or C)
    def set_temp_unit(temp_unit)
      @settings.temp_unit ||= temp_unit
    end 

    # set temperature unit in config file
    def set_api_key(api)
      @settings.api_key = api
    end 

    def location
      @location ||= @settings.location
    end

    def temp_unit
      @temp_unit ||= @settings.temp_unit
    end

    def api_key
      @api_key ||= @settings.api_key
    end

    def has_api_key?
      api_key
    end

    def has_location?
      location
    end

    # load settings from file
    def load
      @settings = Serializer.deserialize(Constants::CONFIG_PATH)
    end

    # save setting to file
    def save
      Seralizer.serialize(Constants::CONFIG_PATH, @settings)
    end

  end
end
