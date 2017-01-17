module BotControllerHelper


  
  def set_event(title, location, day, starttime, endtime)
    start_date = Chronic.parse(day.to_s + " " + starttime.join.to_s).iso8601
    end_date = Chronic.parse(day.to_s + " " + endtime.join.to_s).iso8601
    @event = {
    'summary' => title,
    'location' => location,
    'start' => { 'dateTime' => start_date },
    'end' => { 'dateTime' => end_date },
     }

     client = Google::APIClient.new
     client.authorization.access_token = current_user.oauth_token
     service = client.discovered_api('calendar', 'v3')

     @set_event = client.execute(:api_method => service.events.insert,
                           :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                           :body => JSON.dump(@event),
                           :headers => {'Content-Type' => 'application/json'})

      "I just set #{title} at #{location} in your Calendar from #{day} #{starttime.join} untill #{endtime.join}."
  end

  def set_eventfull
      start_date = $event['start_time'].iso8601
      end_date = $event['end_time']

      if end_date == nil
        end_date = ($event['start_time'] + 3600).iso8601
      else
        end_date = end_date.iso8601
      end
    @event = {
    'summary' => $event['title'],
    'location' => $event['venue_adress'],
    'start' => { 'dateTime' => start_date },
    'end' => { 'dateTime' => end_date },
     }

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})

    "I just set #{$event['title']} at #{$event['venue_adress']} in your Calendar from #{start_date} untill #{end_date}"

  end

  def get_run
    max_free_time = 0
    $last_arr.each do |answer|
      if answer[:hours_available] > max_free_time
        max_free_time = answer[:hours_available]
      end
    end

    runs = Run.where(duration: [0..(max_free_time * 60)])
      if runs.length > 0
        $runs = runs.sort_by { |run| run.duration}
        $run = $runs.pop
        duration = $run.duration
        calories = $run.calories
        fun_fact = $run.fun_fact_about_calories
        distance = $run.distance

        ["A great idea would be to run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]
      else
        ["You don't have time for a run today ☹️"]
      end
  end

  def next_run
    $run = $runs.pop
    duration = $run.duration
    calories = $run.calories
    fun_fact = $run.fun_fact_about_calories
    distance = $run.distance

    ["You lazy piece of shit, run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm fatass, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]
  end

  def set_run(start_time)
    start_date = (Chronic.parse("today #{start_time}"))
    end_date = (start_date + $run.duration.minute)
    @event = {
    'summary' => "#{$run.distance} miles run.",
    'start' => { 'dateTime' => start_date.iso8601 },
    'end' => { 'dateTime' => end_date.iso8601 },
     }

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})

    "I just set a #{$run.distance} miles run at in your Calendar from #{start_date} untill #{end_date}"
  end
end
