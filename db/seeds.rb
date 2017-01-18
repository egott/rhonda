response = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=vegetarian",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

parsed = JSON.parse(response.raw_body)

parsed['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']
  ingredient_name = recipe['extendedIngredients'].map { |i| i['name']}

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
end

response1 = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=fish",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

parsed1 = JSON.parse(response.raw_body)

parsed1['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']
  ingredient_name = recipe['extendedIngredients'].map { |i| i['name']}

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
end

response2 = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=chicken",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

parsed2 = JSON.parse(response.raw_body)

parsed2['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']
  ingredient_name = recipe['extendedIngredients'].map { |i| i['name']}

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
end

response3 = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=salad",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

parsed3 = JSON.parse(response.raw_body)

parsed3['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']
  ingredient_name = recipe['extendedIngredients'].map { |i| i['name']}

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
end

response4 = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=fruit",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

parsed4 = JSON.parse(response.raw_body)

parsed4['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']
  ingredient_name = recipe['extendedIngredients'].map { |i| i['name']}

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
end

response5 = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=egg",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

parsed5 = JSON.parse(response.raw_body)

parsed5['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']
  ingredient_name = recipe['extendedIngredients'].map { |i| i['name']}

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url, instructions: instructions, ingredient_name: ingredient_name)
end



Recipe.where(:ingredient_name => nil).destroy_all
Recipe.where(:time_to_cook => nil).destroy_all


run1 = Run.create!(duration: 60, calories: 540, fun_fact_about_calories: "By running this, you could burn off the bagel and cream cheese you ate! 🏃", distance: 6)
run2 = Run.create!(duration: 30, calories: 270, fun_fact_about_calories: "If you aren't in the mood to run, shoveling snow out of your driveway or raking leaves out of your yard for 30 min will burn the same amount of calories! 😲", distance: 3)
run3 = Run.create!(duration: 120, calories: 1020, fun_fact_about_calories: "Do this run and you will burn off the equivalent of 2 big macs! 🙅 🍔", distance: 12)
run4 = Run.create!(duration: 15, calories: 135, fun_fact_about_calories: "You can fit this quick run in between events on your calender!", distance: 2)
run5 = Run.create!(duration: 45, calories: 340, fun_fact_about_calories: "You could burn off your Burger King Whopper by running this!!! 🍔", distance: 4.5)

runs = [run1, run2, run3, run4, run5]
