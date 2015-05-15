# require 'HTTParty'
require 'httparty'

module Tundra
  module Utils
    # extend self

    WUNDER_URL = "http://api.wunderground.com"

    def self.internet_connection?
      begin
        true if HTTParty.get(WUNDER_URL)
      rescue
        false
      end
    end

    def self.always_true
      true
    end

  end
end
