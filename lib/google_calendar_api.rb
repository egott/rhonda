module GoogleCalendarApi
  extend self

  def set_event(title, location, day, starttime, endtime, user)

    start_date = Chronic.parse(day.to_s + " " + starttime.join.to_s).iso8601
    end_date = Chronic.parse(day.to_s + " " + endtime.join.to_s).iso8601

    @event_cal = {
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
                           :body => JSON.dump(@event_cal),
                           :headers => {'Content-Type' => 'application/json'})
    output = ["I just set #{title} at #{location} in your Calendar from #{day} #{starttime.join} untill #{endtime.join}."]
    Messagizer.messagize(output.first, '', '')
  end

  def get_freetime(user)
    # start_date = current_time.utc.iso8601
    Time.zone = 'EST'
    start_date = Time.now.iso8601
    end_date = (Time.now.end_of_day).iso8601

    client = Google::APIClient.new
    client.authorization.access_token = user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    calendars = client.execute(api_method: service.events.list,
                              :parameters => {'calendarId' => 'primary', 'sendNotifications' => true, timeMin: start_date, timeMax:end_date },
                              :headers => {'Content-Type' => 'application/json'}
                              )

    free_time = calculate_freetime(calendars)
    last_arr = group_open_times(free_time)
    totalstring = ""
    #transition from european system to AM and PM
    last_arr.each do |list_times|
      if list_times[:hour_start] > 12
        list_times[:hour_start] = "#{list_times[:hour_start]- 12} pm"
      elsif
        list_times[:hour_start] = "#{list_times[:hour_start]} am"
      end

      free_time_until = ''
      if list_times[:hour_start][0..-4].to_i < 12 && (list_times[:hour_start][0..-4].to_i + list_times[:hours_available] > 12)
        free_time_untill = "#{(list_times[:hour_start][0..-4].to_i + list_times[:hours_available]) - 12} pm"
      else
        free_time_untill = "#{(list_times[:hour_start][0..-4].to_i + list_times[:hours_available])} pm"
      end

      stringsoffreetime = "You have #{list_times[:hours_available]} hours of free time starting at #{list_times[:hour_start]} untill #{free_time_untill}."
      totalstring += stringsoffreetime
    end
    Messagizer.messagize("Here are your free times for today: #{totalstring}",'','')
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
end
