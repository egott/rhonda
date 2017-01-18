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
      @api_event_location = response[:result][:parameters][:'APIevent-location']
      EventfulApi.get_event(@api_event_subject, @api_event_location)
    when "nextEvent"
      EventfulApi.get_event(@api_event_subject, @api_event_location)
    when "setEventfulEvent"
      EventfulApi.set_eventful(user)
    when "getGiph"
      @subject = response[:result][:parameters][:giphSubject]
      GiphApi.get_giph(@subject)
    when "nextGiph"
      GiphApi.get_giph(@subject)
    when "getRun"
      #need to fix with free time
      RunApi.get_run(user)
    when "nextRun"
      RunApi.next_run
    when "setRun"
      time = response[:result][:parameters][:time]
      RunApi.set_run(time, user)
    when "getWeather"
      location = response[:result][:parameters][:location]
      WeatherApi.get_weather(location)
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
      GoogleCalendarApi.set_event(title, location, day, starttime, endtime, user)
    when "getFreetime"
      GoogleCalendarApi.get_freetime(user)
    when "sendGiph"
      #see picture in my phone
    when "getMarvel"
      character = response[:result][:parameters][:character]
      MarvelApi.get_marvel(character)
    when "getTV"
      show = response[:result][:parameters][:show]
      TvApi.get_tv(show)
    when "setTV"
      time = response [:result][:parameters][:time]
      TvApi.set_tv(time, user)
    end

  end


end
