class HomesController < ApplicationController
  def show
    # # work in progress





    ###########################################################
    # create new event at a given time and date
    ###########################################################
    # current_time = Time.now
    # start_date = current_time.utc.iso8601
    #https://developers.google.com/schemas/formats/datetime-formatting


    # current_time = '2016-01-14T13:15:03-08:00'
    start_date = '2017-01-13T01:15:03-08:00'
    end_date = '2017-01-13T23:15:03-08:00'

    @list_events = {
    'max_results' => 10,
    'single_events' => true,
    'order_by' => 'startTime',
    'time_min' => Time.now.iso8601,
    }

    @event = {
    'summary' => 'New Event Title',
    'description' => 'The description',
    'location' => 'Location',
    'start' => { 'dateTime' => start_date },
    'end' => { 'dateTime' => end_date },
    'attendees' => [ { "email" => 'bob@example.com' },
    { "email" =>'sally@example.com' } ] }

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    # @set_event = client.execute(:api_method => service.events.insert,
    #                       :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
    #                       :body => JSON.dump(@event),
    #                       :headers => {'Content-Type' => 'application/json'})



   ###########################################################
   # view all events
   ###########################################################
  #  @events = client.execute(:api_method => service.events.list,
  #                        :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
  #                        :body => JSON.dump(@list_event),
  #                        :headers => {'Content-Type' => 'application/json'})
  #   puts @events.body
    # @events.each do |event|
    #   start = event.start.date || event.start.dateTime
    #   puts "- #{event.summary} (#{start})"
    # end


    calendars = client.execute(api_method: service.events.list,
                              :parameters => {'calendarId' => 'primary', 'sendNotifications' => true, timeMin: start_date, timeMax:end_date },
                              :headers => {'Content-Type' => 'application/json'}


                              )



    calendars.data.items.each do |event|
      p event.start.dateTime
    end

  end
end
