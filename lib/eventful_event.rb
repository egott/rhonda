module EventfulEvent
  extend self

  def set_eventful(user)
      start_date = $event['start_time']
      end_date = $event['end_time']

      if end_date == nil
        end_date = ($event['start_time'] + 3600)
      else
        end_date = end_date
      end
    @event = {
    'summary' => $event['title'],
    'location' => $event['venue_adress'],
    'start' => { 'dateTime' => start_date },
    'end' => { 'dateTime' => end_date },
     }

    client = Google::APIClient.new
    client.authorization.access_token = user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})

    output = ["I just set #{$event['title']} at #{$event['venue_adress']} in your Calendar from #{start_date.strftime("%A %B %e, %Y at %l:%M %P")} untill #{end_date.strftime("%A %B %e, %Y at %l:%M %P")}"]
    Messagizer.messagize(output.first, '', '')
  end

end
