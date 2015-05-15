# TODO start using thor instead of trollop
require 'trollop'

require 'lib/utils'
require 'lib/weather'

module Tundra
  module Cli
    extend self

    def run
      # setup cli options parser
      opts = Trollop::options do
        opt :location, "Weather for location", :type => String
        opt :export, "File to write ", :type => String
        opt :forecast, "Forecast for number of days specified (up to 10 days).", :type => Integer
        opt :moon, "Shows the current moon percentage."
      end

      # require a location
      if opts[:location] && opts[:location].length == 0
        Trollop::die :location, "Must provide a location" 
      end

      # require forecast between 1 and 10, inclusive
      if !opts[:forecast].nil? && !opts[:forecast].between?(1, 10)
        Trollop::die :forecast, "Number of days needs to be between 1 and 10"
      end

      if Utils.internet_connection?
        # try to use dotfile's location as a fallback
        weather = Weather.new(opts[:location] || Config.location)

        if opts[:forecast]
          weather.find_forecast(opts[:forecast])
        end

        if opts[:moon]
          weather.print_moon_phase
        end

        if !opts[:moon] && !opts[:forecast]
          weather.find_weather
          weather.print_weather(opts[:export])
        end

      else
        puts "Uh Oh...You are not connected to the internet or Wunderground is not responding"
      end

    end

  end
end
