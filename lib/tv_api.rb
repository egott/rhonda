module TvApi
  extend self

  def get_tv(show)
    total_episode = []
    tvdb = Tvdbr::Client.new('BFEEF9792B1697DF')
    @episode = tvdb.find_all_series_by_title(show)
    if @episode[0].finale_aired < Time.now.strftime("%Y-%m-%d") && @episode[0].status == "Ended"
      output = "#{@episode[0].series_name}: #{@episode[0].overview}. The show ended on #{@episode[0].finale_aired}"
    else
      output = "#{@episode[0].series_name}: #{@episode[0].overview}. The show airs on #{@episode[0].airs_day_of_week} at #{@episode[0].airs_time}"
    end
    Messagizer.messagize(output, '', '')
  end

  def set_tv(time, user)
    get_next_airdate = @episode[0].airs_time.to_time
    while get_next_airdate.day != @episode[0].airs_day_of_week
      if get_next_airdate.strftime("%A") == @episode[0].airs_day_of_week
        break
      end
      get_next_airdate = get_next_airdate.next_day
    end

    @event = {
      'summary' => "#{@episode[0].series_name}",
      'start' => { 'dateTime' => get_next_airdate.iso8601 },
      'end' => {'dateTime' => (get_next_airdate + (@episode[0].runtime).to_i.minutes).iso8601}
    }
    #fix 400 request
    client = Google::APIClient.new
    client.authorization.access_token = user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event_cal),
                          :headers => {'Content-Type' => 'application/json'})
    output = "I just set the show #{@episode[0].series_name} in your calendar for next #{@episode[0].airs_day_of_week} at #{@episode[0].airs_time}"

    Messagizer.messagize(output, '', '')
  end
end
