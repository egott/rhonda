module BotControllerHelper

  def set_run(start_time)
    start_date = (Chronic.parse("today #{start_time}"))
    end_date = (start_date + $run.duration.minute)
    @event = {
    'summary' => "#{$run.distance} miles run.",
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

    "I just set a #{$run.distance} miles run at in your Calendar from #{start_date} untill #{end_date}"
  end
  
end
