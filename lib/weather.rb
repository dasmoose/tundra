require 'hashie'
require 'httparty'
require 'json'
require 'terminal-table'

require 'lib/constants'
require 'lib/utils'

module Tundra
  class Weather
    attr_accessor :location_name, :current_temp, :description, :error, :icon

    def initialize(location_name)
      @location_name = location_name
      @location = location_name.gsub(' ', '_')
    end

    def find_weather
      url = Utils.get_current_url(Config.api_key, @location)
      response = HTTParty.get url
      parsed = JSON.parse response.body
      weather = Hashie::Mash.new parsed

      if !weather.response.error
        current = weather.current_observation
        @location_name = current.display_location.full
        @description = current.weather
        @current_temp = current.temp_f
        @icon = current.icon
      else
        puts "Cannot find location #{@location_name}"
        @error = true
      end
    end

    def find_forecast(num_days)
      url = Utils.get_ten_day_url(Config.api_key, @location)
      response = HTTParty.get url
      parsed = JSON.parse response.body
      weather = Hashie::Mash.new parsed

      days = ["Day"]
      highs = ["High"]
      lows = ["Low"]
      conditions = ["Condition"]
      table = Terminal::Table.new :title => "#{num_days} Day Forecast for #{@location_name}"

      if !weather.response.error
          weather_arr = weather.forecast.simpleforecast.forecastday
          (0..num_days-1).each do |day|
            days << weather_arr[day]['date']['weekday_short']
            highs << weather_arr[day]['high']['fahrenheit']
            lows << weather_arr[day]['low']['fahrenheit']
            conditions << weather_arr[day]['conditions']
            table.align_column(day, :center)
          end

          weather_table = [highs, lows, conditions]
          table.headings = days
          table.rows = weather_table
          puts table
      else
        puts "Cannot find location #{@location_name}"
        @error = true
      end
    end

    def print_moon_phase
      url = Utils.get_moon_url(Config.api_key, @location)
      response = HTTParty.get url
      parsed = JSON.parse response.body
      moon = Hashie::Mash.new parsed

      if !moon.response.error
        percentage = moon.moon_phase.percentIlluminated
        puts Constants::MOONS[(percentage.to_i/20)].gsub('@', ' ')
        puts "\nPercentage: #{percentage}%"
      else
        puts "Cannot find location #{@location_name}"
        @error = true
      end
    end

    def print_weather
      if @error
        puts "Error requesting the moon phase. Try again later."
      else
        puts "#{@current_temp} F #{@description}"
      end
    end

  end
end
