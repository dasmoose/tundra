require 'hashie'
require 'json'

# Adapted from @cknadler's git-feats gem. 

module Tundra
  module Serializer
    
    extend self

    # serialize a ruby object to a file in json
    #
    # path - file path
    # data - data to be serialized
    #
    # Returns nothing
    def serialize(path, data)
      # Make a path to the data file if one doesn't already exist
      dir = File.dirname path
      FileUtils.mkpath(dir) unless File.directory?(dir)

      File.open(path, "w") do |f|
        f.puts data.to_json
      end
    end

    # Deserialize a json file to a ruby object.
    # If no file exists at `path`, this will return silently
    #
    # path - file path
    #
    # Returns a Hashie::Mash object
    def deserialize(path)
      # Read file if it exists and is not empty
      if File.exist?(path) && !File.zero?(path)
        begin
          parsed = JSON.parse(IO.read(path))
          return Hashie::Mash.new parsed
        rescue JSON::ParserError => e
          puts e
        end
      end 
    end
  end
end
