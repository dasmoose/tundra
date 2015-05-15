# Tundra
weather where you need it...on the command line

### dependencies
- ruby
- rvm
- gem

### setup
- `git clone git@github.com:dasmoose/tundra.git`
- (OPTIONAL) create a dotfile for tundra:
  - `touch ~/.tundra`
  - `echo "{ "location": "Oakland", "api_key": "1234567890abcdef", "temp_unit": "F" }" >> ~/.tundra`

### dotfile
You can create a json dotfile in your home directory that specifies a few pieces of info:
- Weather Underground api_key [Sign Up Here](http://www.wunderground.com/weather/api/)
- location (e.g. Oakland, San Francisco, Seattle)
- temp_unit (e.g. F or C)

Here's an example:
```json
{                                                                                
  "location": "Oakland",                                                         
  "api_key": "1234567890abcdef",                                                 
  "temp_unit": "F"                                                                  
}  
```

### usage
- For the current weather in a particular city:
  - `ruby weather.rb --location=oakland`
- Or if you have a dotfile with location specified, you only have to run:
  - `ruby weather.rb`
- For a 5 day forecast (assumes location is in dotfile):
  - `ruby weather.rb --forecast=5`
- For the current moon cycle (assumes location is in dotfile):
  - `ruby weather.rb --moon`
