class HomesController < ApplicationController
  def show
    # work in progress
    d = Time.now+1
    date = d.utc.iso8601
    @event = {
    'summary' => 'New Event Title',
    'description' => 'The description',
    'location' => 'Location',
    'start' => { 'dateTime' => date },
    'end' => { 'dateTime' => date },
    'attendees' => [ { "email" => 'bob@example.com' },
    { "email" =>'sally@example.com' } ] }

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'rhonda.bot5@gmail.com', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})
  end
end
