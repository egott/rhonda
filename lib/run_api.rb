module RunApi
  extend self

  def get_run(user)
    Time.zone = 'EST'
    start_date = Time.now.iso8601
    end_date = (Time.now.end_of_day).iso8601

    client = Google::APIClient.new
    client.authorization.access_token = user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    calendars = client.execute(api_method: service.events.list,
                              :parameters => {'calendarId' => 'primary', 'sendNotifications' => true, timeMin: start_date, timeMax:end_date },
                              :headers => {'Content-Type' => 'application/json'}
                              )
    free_time = GoogleCalendarApi.calculate_freetime(calendars)
    last_arr = GoogleCalendarApi.group_open_times(free_time)

    max_free_time = 0
    last_arr.each do |answer|
      if answer[:hours_available] > max_free_time
        max_free_time = answer[:hours_available]
      end
    end

    runs = Run.where(duration: [0..(max_free_time * 60)])
      if runs.length > 0
        @runs = runs.sort_by { |run| run.duration}
        @run = @runs.pop
        duration = @run.duration
        calories = @run.calories
        fun_fact = @run.fun_fact_about_calories
        distance = @run.distance

        ouput = ["A great idea would be to run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]
      else
        output = ["You don't have time for a run today ☹️"]
      end
      Messagizer.messagize(ouput.sample, '', '')
  end

  def next_run
    @run = @runs.sample
    duration = @run.duration
    calories = @run.calories
    fun_fact = @run.fun_fact_about_calories
    distance = @run.distance

    output = ["You lazy slob, run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm fatass, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]

    Messagizer.messagize(output.sample, '', '')
  end

  def set_run(start_time, user)
    start_date = (Chronic.parse("today #{start_time}"))
    end_date = (start_date + @run.duration.minute)
    @event = {
    'summary' => "#{@run.distance} miles run.",
    'start' => { 'dateTime' => start_date.iso8601 },
    'end' => { 'dateTime' => end_date.iso8601 },
     }

    client = Google::APIClient.new
    client.authorization.access_token = user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})

    output = "I just set a #{@run.distance} miles run at in your Calendar from #{start_date.strftime("%A %B %e, %Y at %l:%M %P")} untill #{end_date.strftime("%A %B %e, %Y at %l:%M %P")}"

    Messagizer.messagize(output, '', '')
  end

end
