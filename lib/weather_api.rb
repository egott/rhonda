module WeatherApi
  extend self

  def get_weather(location)

    response = Weather.lookup_by_location(location, Weather::Units::FAHRENHEIT)

    response.forecasts.each do |day|
      if day.date.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")
        @output = "Todays high:#{day.high}, low: #{day.low}; #{day.text}"
        break
      else
        @output = "no output"
      end
    end
    Messagizer.messagize(@output, '', '')
  end

end
