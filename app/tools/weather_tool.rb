require 'open-uri'

class WeatherTool < RubyLLM::Tool
  # get the weather of a specific location
  description "Get the weather of a specific location."
  param :latitude, desc: "Latitude of a location (e.g. 35.64148995)"
  param :longitude, desc: "Longitude of a location (e.g. 139.69827334)"

  # this is how the ruby llm runs the tool
  def execute(latitude:, longitude:)
    # get the weather api url
    url = "https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m,wind_speed_10m"
    response = URI.open(url).read # json string
    JSON.parse(response) # ruby object
  end
end
