module BotControllerHelper
  def get_recipe(ingredient)
    recipes = Recipe.all

    recipes = recipes.select { |recipe| recipe.ingredient_name.include? ingredient}
    recipe = recipes.sample
    name = recipe.name
    ingredient = recipe.ingredient_name
    instruction = recipe.instructions
    time = recipe.time_to_cook.to_i + recipe.time_to_prepare.to_i
    link = recipe.source_url

    ["My suggestion would be #{name}, it takes #{time} minutes to cook. Find more information on #{link}. Say next if you want another recipe.", "I found this great recipe: #{name}, if you have #{time} minutes to spare. Sounds delicious? Look it up here: #{link}. Doesn't please you? just type next."]
  end

  def get_event(subject, location)
    eventful = Eventful::API.new 'WZZ294GGCHG2rfjW'
    # debugger;
    results = eventful.call 'events/search',
                            :keywords => subject,
                            :location => location,
                            :page_size => 50
    $event = results.first[1]['event'].sample
    ["There is an event at #{$event['venue_name']}, on #{$event['start_time']}. For more information, click here #{$event['venue_url']}!",
    "I found an awesome event at #{$event['venue_name']}. The event is on #{$event['start_time'].iso8601}, go here to learn more about it! #{$event['venue_url']} 🤘"
  ]

  end

  def set_event(title, location, day, starttime, endtime)
    start_date = Chronic.parse(day.to_s + " " + starttime.join.to_s).iso8601
    end_date = Chronic.parse(day.to_s + " " + endtime.join.to_s).iso8601

    @event = {
    'summary' => title,
    'location' => location,
    'start' => { 'dateTime' => start_date },
    'end' => { 'dateTime' => end_date },
     }

     client = Google::APIClient.new
     client.authorization.access_token = current_user.oauth_token
     service = client.discovered_api('calendar', 'v3')

     @set_event = client.execute(:api_method => service.events.insert,
                           :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                           :body => JSON.dump(@event),
                           :headers => {'Content-Type' => 'application/json'})

      "I just set #{title} at #{location} in your Calendar from #{day} #{starttime.join} untill #{endtime.join}."
  end

  def set_eventfull
      start_date = $event['start_time'].iso8601
      end_date = $event['end_time']

      if end_date == nil
        end_date = ($event['start_time'] + 3600).iso8601
      else
        end_date = end_date.iso8601
      end
    @event = {
    'summary' => $event['title'],
    'location' => $event['venue_adress'],
    'start' => { 'dateTime' => start_date },
    'end' => { 'dateTime' => end_date },
     }

    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                          :body => JSON.dump(@event),
                          :headers => {'Content-Type' => 'application/json'})

    "I just set #{$event['title']} at #{$event['venue_adress']} in your Calendar from #{start_date} untill #{end_date}"

  end
end
