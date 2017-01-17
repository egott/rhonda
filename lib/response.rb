module Response
  extend self

  def api_distr(response, user)

    case response[:result][:action]
    when "getRecipe"
      @ingredient = response[:result][:parameters][:food]
      RecipeApi.get_recipe(@ingredient)
    when "nextRecipe"
      RecipeApi.get_recipe(@ingredient)
    when "getAPIevent"
      @api_event_subject = response[:result][:parameters][:'APIevent-subject']
      @api_event_location = response[:result][:parameters][:'api_event_location']
      EventfulApi.get_event(@api_event_subject, @api_event_location)
    when "nextEvent"
      EventfulApi.get_event(@api_event_subject, @api_event_location)
    when "getGiph"
      @subject = response[:result][:parameters][:giphSubject]
      GiphApi.get_giph(@subject)
    when "nextGiph"
      GiphApi.get_giph(@subject)
    when "getRun"
      #need to fix with free time
      Run.get_run
    when "getWeather"
      #not working
      WeatherApi.get_weather
    when "getTv"
      @show = response[:result][:parameters][:show]
      TvApi.get_tv(@show)
    when "setEvent"
      title = response[:result][:parameters][:eventtitle]
      if title == ""
        title = "event"
      end
      location = response[:result][:parameters][:eventlocation]
      day = response[:result][:parameters][:eventstart]
      starttime = response[:result][:parameters][:eventtime].join.split[0..1]
      endtime = response[:result][:parameters][:eventtime].join.split[-2..-1]
      SetEvent.set_event(title, location, day, starttime, endtime, user)
    when "setEventfulEvent"
      EventfulEvent.set_eventful(user)
    end

  end


end
