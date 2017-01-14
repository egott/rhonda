class BotsController < ApplicationController
  include BotControllerHelper
  include BotControllerHelper2
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
      response =
              {
                "speech": "#{get_recipe.sample}"
              }
    elsif response[:result][:action] == "nextRecipe"
      response =
          {
            "speech": "#{get_recipe.sample}"
          }
    elsif response[:result][:action] == "getFreetime"
      response =
          {
            "speech": "#{get_freetime}"
          }
    else
        response = response[:result][:fulfillment]
    end
      render json: response
  end




end
