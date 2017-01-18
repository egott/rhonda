module RecipeApi
  extend self

  def get_recipe(ingredient)
    recipes = Recipe.all

    recipes = recipes.select { |recipe| recipe.ingredient_name.include? ingredient}
    recipe = recipes.sample
    name = recipe.name
    ingredient = recipe.ingredient_name
    instruction = recipe.instructions
    time = recipe.time_to_cook.to_i + recipe.time_to_prepare.to_i
    recipe_link = recipe.source_url

    output = ["My suggestion would be #{name}, it takes #{time} minutes to cook. Say next recipe if you want another recipe.", "I found this great recipe: #{name}, if you have #{time} minutes to spare. Doesn't please you? just type next recipe."]
    Messagizer.messagize(output.sample, recipe_link, '')
  end
end
