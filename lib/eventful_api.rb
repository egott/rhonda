module EventfulApi
  extend self

  def get_event(subject, location)
    eventful = Eventful::API.new 'WZZ294GGCHG2rfjW'
    results = eventful.call 'events/search',
      :keywords => subject,
      :location => location,
      :page_size => 5
    $event = results.first[1]['event'].sample
    url = $event['venue_url']


    output = ["There is an event: #{$event['title']} at #{$event['venue_name']}, on #{$event['start_time'].strftime("%A %B %e, %Y at %l:%M %P")}.",
    "I found an awesome event: #{$event['title']} at #{$event['venue_name']}. The event is on #{$event['start_time'].strftime("%A %B %e, %Y at %l:%M %P")} 🤘."]
    Messagizer.messagize(output.sample, url, '')
  end
end
