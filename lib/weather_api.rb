module WeatherApi
  extend self

  def get_weather
    output = Weather.lookup_by_location('New York, NY', Weather::Units::FAHRENHEIT)
    Messagizer.messagize(output, '', '')
  end

end
