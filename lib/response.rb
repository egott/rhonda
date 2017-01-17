module Response
  extend self
  def api_distr(response)
    case response[:result][:action]
    when "getRecipe"
      $ingredient = response[:result][:parameters][:food]
      RecipeApi.get_recipe($ingredient)
    end
  end

  def hello
    puts "hello"
  end
end
