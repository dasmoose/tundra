require 'json'

# Communicates with wunderground and 
# returns parsed json
module Tundra
	module wunderground
		# Knows how to communicate with wunderground

		def get_country_code

		end

		# Request forcast
		def get_forcast

		end

		# Request Current Weather
		def get_current
		
		end

		# Request Moon 
		def get_moon

		end

		private 
		def api_key
			@api_key = Config.api_key
		end
	end
end