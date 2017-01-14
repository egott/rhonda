class BotsController < ApplicationController
  def initialize
    $rhonda = ApiAiRuby::Client.new(
    :client_access_token => "21136391b2cd47d7bbf7e5f7813287dc"
    )
  end

  def index
  end

  def get_response
    response = $rhonda.text_request params["user_input"]
    if response[:result][:action] == "getRecipe"
      recipe = Recipe.all.sample
      name = recipe.name
      ingredient = recipe.ingredient_name
      instruction = recipe.instructions
      time = recipe.time_to_cook.to_i + recipe.time_to_prepare.to_i
      link = recipe.source_url
      response =
        {
          "speech": "My suggestion would be #{name}, it takes #{time} minutes to cook. Instructions: #{instruction}. Find more information on #{link}",
          "displayText": "My suggestion would be #{name}, it takes #{time} minutes to cook. Instructions: #{instruction}. Find more information on #{link}",
          "data": "",
          "source": "Rhondatest"
        }
      else
        response
      end
    end
      render json: response
  end




end
