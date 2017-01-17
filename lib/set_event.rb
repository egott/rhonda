module SetEvent
  extend self

  def set_event(title, location, day, starttime, endtime, user)
    start_date = Chronic.parse(day.to_s + " " + starttime.join.to_s)
    end_date = Chronic.parse(day.to_s + " " + endtime.join.to_s)
    @event = {
    'summary' => title,
    'location' => location,
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

    output = ["I just set #{title} at #{location} in your Calendar from #{day} #{starttime.join} untill #{endtime.join}."]
    Messagizer.messagize(output.first, '', '')
  end
end
