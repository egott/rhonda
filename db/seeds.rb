# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'unirest'

vegetarian = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=100&tags=vegetarian",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"}
)

vegetarian = JSON.parse(response.raw_body)

vegetarian['recipes'].each do |recipe|
  name = recipe['title']
  ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
  instructions = recipe['instructions']
  time_to_prepare = recipe['preparationMinutes']
  time_to_cook = recipe['cookingMinutes']
  source_url = recipe['sourceUrl']

  recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
end

# response1 = Unirest.get(
#   "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=fish",
#   headers: {
#       "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
#       "Accept" => "application/json"}
# )
#
# parsed1 = JSON.parse(response.raw_body)
#
# parsed1['recipes'].each do |recipe|
#   name = recipe['title']
#   ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
#   instructions = recipe['instructions']
#   time_to_prepare = recipe['preparationMinutes']
#   time_to_cook = recipe['cookingMinutes']
#   source_url = recipe['sourceUrl']
#
#   recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
# end
#
# response2 = Unirest.get(
#   "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=chicken",
#   headers: {
#       "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
#       "Accept" => "application/json"}
# )
#
# parsed2 = JSON.parse(response.raw_body)
#
# parsed2['recipes'].each do |recipe|
#   name = recipe['title']
#   ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
#   instructions = recipe['instructions']
#   time_to_prepare = recipe['preparationMinutes']
#   time_to_cook = recipe['cookingMinutes']
#   source_url = recipe['sourceUrl']
#
#   recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
# end
#
# response1 = Unirest.get(
#   "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1000&tags=salad",
#   headers: {
#       "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
#       "Accept" => "application/json"}
# )
#
# parsed1 = JSON.parse(response.raw_body)
#
# parsed1['recipes'].each do |recipe|
#   name = recipe['title']
#   ingredients = recipe['extendedIngredients'].map {|i| i['originalString']}
#   instructions = recipe['instructions']
#   time_to_prepare = recipe['preparationMinutes']
#   time_to_cook = recipe['cookingMinutes']
#   source_url = recipe['sourceUrl']
#
#   recipe = Recipe.create!(name: name, ingredients: ingredients, time_to_prepare: time_to_prepare, time_to_cook: time_to_cook, source_url: source_url)
# end


seed all healthy things
get ingredients out of string
get ingredient name out of string
