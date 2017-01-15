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
end
