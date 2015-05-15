require 'httparty'

require 'lib/config'
require 'lib/constants'

module Tundra
  module Utils
    extend self

    def internet_connection?
      begin
        true if HTTParty.get(Constants::WUNDER_URL)
      rescue
        false
      end
    end

    def get_current_url(api_key, location)
      Constants::CURRENT_URL % [api_key, location]
    end

    def get_ten_day_url(api_key, location)
      Constants::TEN_DAY_URL % [api_key, location]
    end

    def get_moon_url(api_key, location)
      Constants::MOON_URL % [api_key, location]
    end

  end
end
