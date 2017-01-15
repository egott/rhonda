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
end
