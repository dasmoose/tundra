module Tundra
  module Constants

    CONFIG_PATH = File.join(Dir.home, '.tundra')
    WUNDER_URL = 'http://api.wunderground.com'
    RESPONSE = 'json'

    CURRENT_URL = 'http://api.wunderground.com/api/%s/conditions/q/CA/%s.json'
    TEN_DAY_URL = 'http://api.wunderground.com/api/%s/forecast10day/q/CA/%s.json'
    MOON_URL = 'http://api.wunderground.com/api/%s/astronomy/q/CA/%s.json'

    MOONS = [ "@@@@@@@_..._\n@@@@@.'   `.\n@@@@:       :\n@@@@:         :\n@@@@`.       .'\n@@@@@@`-...-' \n",
          "@@@@@@@_..._\n@@@@@.::'   `.\n@@@@:::       :\n@@@@:::       :\n@@@@`::.     .'\n@@@@@@`':..-' \n",
          "@@@@@@@_..._\n@@@@@.::::  `.\n@@@@::::::    :\n@@@@::::::    :\n@@@@`:::::   .'\n@@@@@@`'::.-' \n",
          "@@@@@@@_..._\n@@@@@.::::. `.\n@@@@:::::::.  :\n@@@@::::::::  :\n@@@@`::::::' .'\n@@@@@@`'::'-' \n",
          "@@@@@@@_..._\n@@@@@.:::::::.\n@@@@:::::::::::\n@@@@:::::::::::\n@@@@`:::::::::'\n@@@@@@`'::::' \n" ]

  end
end
