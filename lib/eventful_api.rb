module EventfulApi
  require 'eventful/api'
  extend self

  def get_event(subject, location)
    eventful = Eventful::API.new 'WZZ294GGCHG2rfjW'
    results = eventful.call 'events/search',
      :keywords => subject,
      :location => location,
      :page_size => 5
    @event = results.first[1]['event'].sample
    url = @event['venue_url']


    output = ["There is an event: #{@event['title']} at #{@event['venue_name']}, on #{@event['start_time'].strftime("%A %B %e, %Y at %l:%M %P")}.",
    "I found an awesome event: #{@event['title']} at #{@event['venue_name']}. The event is on #{@event['start_time'].strftime("%A %B %e, %Y at %l:%M %P")} 🤘."]
    Messagizer.messagize(output.sample, url, '')
  end

  def set_eventful(user)
      start_date = @event['start_time']
      end_date = @event['end_time']

      if end_date == nil
        end_date = (@event['start_time'] + 3600)
      else
        end_date = end_date
      end
    @event_cal = {
    'summary' => @event['title'],
    'location' => @event['venue_adress'],
    'start' => { 'dateTime' => start_date.iso8601 },
    'end' => { 'dateTime' => end_date.iso8601 },
     }

    client = Google::APIClient.new
    client.authorization.access_token = user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event_cal),
                          :headers => {'Content-Type' => 'application/json'})

    output = ["I just set #{@event['title']} at #{@event['venue_adress']} in your Calendar from #{start_date.strftime("%A %B %e, %Y at %l:%M %P")} untill #{end_date.strftime("%A %B %e, %Y at %l:%M %P")}"]
    Messagizer.messagize(output.first, '', '')
  end

end
