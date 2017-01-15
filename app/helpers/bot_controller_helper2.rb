module BotControllerHelper2
  def get_recipe
    recipe = Recipe.all.sample
    name = recipe.name
    ingredient = recipe.ingredient_name
    instruction = recipe.instructions
    time = recipe.time_to_cook.to_i + recipe.time_to_prepare.to_i
    link = recipe.source_url

    ["My suggestion would be #{name}, it takes #{time} minutes to cook. Find more information on #{link}. Say next if you want another recipe.", "I found this great recipe: #{name}, if you have #{time} minutes to spare. Sounds delicious? Look it up here: #{link}. Doesn't please you? just type next."]
  end



  def get_freetime
    # start_date = current_time.utc.iso8601
    Time.zone = 'EST'
    start_date = Time.now.iso8601
    end_date = (Time.now + 1.day).iso8601

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    calendars = client.execute(api_method: service.events.list,
                              :parameters => {'calendarId' => 'primary', 'sendNotifications' => true, timeMin: start_date, timeMax:end_date },
                              :headers => {'Content-Type' => 'application/json'}
                              )

    free_time = []
    previous_date = start_date.to_datetime.to_i
    #loop through all 24 hours of day and check  whether each hour overlaps with a event
    #if they overlap then that time is not free
    (start_date.to_datetime.to_i .. end_date.to_datetime.to_i).step(1.hour) do |date|
      #loop through all the events for the day
      calendars.data.items.each do |event|
        if !(previous_date..(date+1.hour)).overlaps?(event.start.dateTime.to_i .. event.end.dateTime.to_i)
      
          free_time << Time.at(previous_date)
          break
        end
      end
      previous_date = date
    end
    p free_time
    num_of_hours = 0
    previous_hour = Time.now.hour - 1
    group_of_hours = []
    final_group_of_hours = []
    #formatting the available free time.
    #looping through free time to chunk them together
    free_time[1..-1].each do |free_time_formatted|
      if ((previous_hour+1) == (free_time_formatted.hour))
        num_of_hours += 1
        group_of_hours << free_time_formatted.hour
      else
        group_of_hours << num_of_hours
        final_group_of_hours << group_of_hours
        num_of_hours = 0
        group_of_hours = []
      end
      previous_hour = free_time_formatted.hour
    end

    last_arr = []
    final_group_of_hours.each do |groups|
      freetime = {
        hours_available: groups.last,
        hour_start: groups.first
      }
      last_arr << freetime
    end
    p last_arr
    totalstring = ""
    last_arr.each do |list_times|
      stringsoffreetime = "You have #{list_times[:hours_available]} hours that are free starting at #{list_times[:hour_start]}--"
      totalstring = totalstring + stringsoffreetime
    end
    p totalstring
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



end
