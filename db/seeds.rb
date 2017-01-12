# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'unirest'

# recipes = Recipe.all
#
# found = Unirest.get "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=200&tags=#{vegeterian}"
# JSON.parse(found.raw_body)

response = Unirest.get(
  "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1&tags=vegetarian",
  headers: {
      "X-Mashape-Key" => "rNL1Zb0lVAmsh8ds5UuGMzh1RLWBp106F33jsnx9oGIFNU46Zn",
      "Accept" => "application/json"},
  parameters: {
    :description => "vegeterian"
  }.to_json
)
