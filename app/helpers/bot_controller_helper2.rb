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

    free_time = calculate_freetime(calendars)

    last_arr = group_open_times(free_time)

    $last_arr = last_arr
    totalstring = ""

    last_arr[0..-2].each do |list_times|

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
    Time.zone = 'EST'
    start_date = Time.now.iso8601
    end_date = (Time.now.end_of_day + 1.hour).iso8601
    free_time = []
    all_day_free = []
    num = 0
    total_events_for_day = calendar_events.data.items.length
    previous_date = start_date.to_datetime.to_i
    #loop through all 24 hours of day and check  whether each hour overlaps with a event
    #if they overlap then that time is not free
    (start_date.to_datetime.to_i .. end_date.to_datetime.to_i).step(1.hour) do |date|
        #loop through all the events for the day
        all_day_free << Time.at(date)
        num = 0
        calendar_events.data.items.each do |event|

          if !(previous_date..(date+1.hour)).overlaps?(event.start.dateTime.to_i .. event.end.dateTime.to_i)
            num += 1
            if num == total_events_for_day
              free_time << Time.at(previous_date)
              num = 0
            end
          end
        end
        previous_date = date
    end
    if free_time.empty?
      return all_day_free
    else

      return free_time
    end
  end

  def group_open_times(free_time)
    num_of_hours = 0
    previous_hour = free_time.first.hour
    group_of_hours = []
    final_group_of_hours = []
    #formatting the available free time.
    #looping through free time to chunk them together
    free_time[1..-1].each do |free_time_formatted|

      if ((previous_hour.next) == (free_time_formatted.hour))
        num_of_hours += 1
        group_of_hours << previous_hour
      else
        num_of_hours += 1
        group_of_hours << previous_hour
        group_of_hours << num_of_hours
        final_group_of_hours << group_of_hours
        num_of_hours = 0
        group_of_hours = []
      end
      previous_hour = free_time_formatted.hour
    end
    group_of_hours << num_of_hours
    final_group_of_hours << group_of_hours
    last_arr = []
    final_group_of_hours.each do |groups|
      freetime = {
        hours_available: groups.last,
        hour_start: groups.first
      }
      last_arr << freetime
    end
    return last_arr

  end




end
