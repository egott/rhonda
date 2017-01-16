module BotControllerHelper2

  def get_freetime
    # start_date = current_time.utc.iso8601
    Time.zone = 'EST'
    start_date = Time.now.iso8601
    end_date = (Time.now.end_of_day).iso8601

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    calendars = client.execute(api_method: service.events.list,
                              :parameters => {'calendarId' => 'primary', 'sendNotifications' => true, timeMin: start_date, timeMax:end_date },
                              :headers => {'Content-Type' => 'application/json'}
                              )
    get_tv
    free_time = calculate_freetime(calendars)
    last_arr = group_open_times(free_time)
    $last_arr = last_arr
    totalstring = ""
    last_arr.each do |list_times|

      if list_times[:hour_start] > 12
        list_times[:hour_start] = "#{list_times[:hour_start]- 12} pm"
      elsif
        list_times[:hour_start] = "#{list_times[:hour_start]} am"
      end
      stringsoffreetime = "You have #{list_times[:hours_available]} hours of free time today starting at #{list_times[:hour_start]} untill #{list_times[:hour_start][-4..-1].to_i + list_times[:hours_available]} #{list_times[:hour_start][-2..-1]}. "
      totalstring = totalstring + stringsoffreetime
    end
    "Here are your free times for today: #{totalstring}"
  end

  def insert_event
    start_date = Time.now.utc.iso8601
    end_date = (Time.now + 1.day).utc.iso8601

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

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})
  end


  def calculate_freetime(calendar_events)
    full_day = {}
    (0..24).each do |i|
      full_day[i] = true
    end
    calendar_events.data.items.each do |event|
      full_day[event.start.dateTime.hour] = false
    end
    full_day
  end

  def group_open_times(free_time)
    Time.zone = 'EST'
    start_date = Time.now.hour
    end_date = Time.now.end_of_day.hour
    group_of_hours = []
    final_group_of_hours = []
    num_of_hours = 0
    (start_date..end_date).step(1) do |i|
      if free_time[i]
        group_of_hours << i
      else
        final_group_of_hours << group_of_hours
        group_of_hours = []
      end
    end
    final_group_of_hours << group_of_hours
    final_group_of_hours.delete_if {|x| x.empty?}
    last_arr = []
    final_group_of_hours.each do |groups|
      freetime = {
        hours_available: groups.length,
        hour_start: groups.first
      }
      last_arr << freetime
    end
    return last_arr
  end

  def get_weather
    response = Weather.lookup_by_location('New York, NY', Weather::Units::FAHRENHEIT)
    p response


  end

  def get_marvel
    @client = Marvel::Client.new
    @client.configure do |config|
      config.api_key = 'a87a5938193d3e9dccc0f1f713fee785'
      config.private_key = '3e199647d1dc793120dc16a07e3c308ef2cfadb4'
    end
    response = @client.characters(nameStartsWith: 'sp', orderBy: 'modified')
    p response
  end

  def get_tv(show)
    total_episode = []
    tvdb = Tvdbr::Client.new('BFEEF9792B1697DF')
    episode = tvdb.find_all_series_by_title(show)
    "#{episode[0].series_name}: #{episode[0].overview}."
  end

end
