#!/usr/bin/env ruby
require 'open-uri'
require 'json'
require 'trollop'
require 'terminal-table'

API_KEY = "8b8f5f91e32d2fb1"
WUNDER_URL = "http://api.wunderground.com"
CURRENT_URL = "http://api.wunderground.com/api/#{API_KEY}/conditions/q/CA/"
TEN_DAY_URL = "http://api.wunderground.com/api/#{API_KEY}/forecast10day/q/CA/"
MOON_URL = "http://api.wunderground.com/api/#{API_KEY}/astronomy/q/CA/"
RESPONSE = "json"

@@moons = [ "@@@@@@@_..._\n@@@@@.'   `.\n@@@@:       :\n@@@@:         :\n@@@@`.       .'\n@@@@@@`-...-' \n",
		  "@@@@@@@_..._\n@@@@@.::'   `.\n@@@@:::       :\n@@@@:::       :\n@@@@`::.     .'\n@@@@@@`':..-' \n",
		  "@@@@@@@_..._\n@@@@@.::::  `.\n@@@@::::::    :\n@@@@::::::    :\n@@@@`:::::   .'\n@@@@@@`'::.-' \n",
		  "@@@@@@@_..._\n@@@@@.::::. `.\n@@@@:::::::.  :\n@@@@::::::::  :\n@@@@`::::::' .'\n@@@@@@`'::'-' \n",
		  "@@@@@@@_..._\n@@@@@.:::::::.\n@@@@:::::::::::\n@@@@:::::::::::\n@@@@`:::::::::'\n@@@@@@`'::::' \n" ]

class Weather
	attr_accessor :location_name, :current_temp, :description, :error, :icon

	def initialize(location_name)
		@location_name = location_name
	end

	def find_weather
		open(CURRENT_URL + @location_name.gsub(" ", "_") + "." + RESPONSE) do |f|
		  json_string = f.read
		  parsed_json = JSON.parse(json_string)
		  if !parsed_json['response']['error']
		  	  @location_name = parsed_json['current_observation']['display_location']['full']
			  @description =  parsed_json['current_observation']['weather']
			  @current_temp = parsed_json['current_observation']['temp_f']
			  @icon = parsed_json['current_observation']['icon']
		  else
		  	puts "Cannot find location #{@location_name}"
		  	@error = true
		  end
		end
	end

	def find_forcast(num_days)
		open(TEN_DAY_URL + @location_name.gsub(" ","_") + "." + RESPONSE) do |f|
			json_string = f.read
			parsed_json = JSON.parse(json_string)
			
			days = ["Day"]
			highs = ["High"]
			lows = ["Low"]
			conditions = ["Condition"]
			table = Terminal::Table.new :title => "#{num_days} Day Forecast for #{@location_name}"


			if !parsed_json['response']['error']
				weather_arr = parsed_json['forecast']['simpleforecast']['forecastday']
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
	end

	def print_moon_phase
		open(MOON_URL + @location_name.gsub(" ","_") + "." + RESPONSE) do |f|
			json_string = f.read
			parsed_json = JSON.parse(json_string)

			if !parsed_json['response']['error']
				
				percentage = parsed_json['moon_phase']['percentIlluminated']
				puts @@moons[(percentage.to_i/20)].gsub('@', " ")
				puts "\nPercentage: #{percentage}%"
			end
		end	
	end

	def print_weather(file)
		weather_str = "#{@current_temp} F #{@description}"
		if !@error && !file
			puts weather_str
		elsif !@error
			f = File.new(file,"w")
			f.puts weather_str
			f.close
			`cp ~/icons/#{icon}.png ~/icons/current.png`
		end
	end
end	

def internet_connection?
	begin
		true if open(WUNDER_URL)
	rescue
		false
	end
end


opts = Trollop::options do
  opt :location, "Weather for location", :type => String
  opt :export, "File to write ", :type => String
  opt :forecast, "Display the forcast for number of days specified (up to 10 days).", :type => Integer
  opt :moon, "Shows the current moon percentage."
end

Trollop::die :location, "Must provide a location" if opts[:location] && opts[:location].length == 0
if !opts[:forecast].nil?
	Trollop::die :forecast, "Number of days needs to be between 1 and 10" if opts[:forecast] > 10 || opts[:forecast] < 1
end

if internet_connection?
	weather = Weather.new(opts[:location])
	if opts[:forecast]
		weather.find_forcast(opts[:forecast])
	end
	if opts[:moon] 
		weather.print_moon_phase
	end
	if !opts[:moon] && !opts[:forecast] 
		weather.find_weather
		weather.print_weather(opts[:export])
	end
		
else
	puts "You are not connected to the internet or Wunderground is not responding"
end
