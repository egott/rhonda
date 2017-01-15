class BotsController < ApplicationController
  include BotControllerHelper
  include BotController3Helper

  def initialize
    $rhonda = ApiAiRuby::Client.new(
    :client_access_token => "21136391b2cd47d7bbf7e5f7813287dc"
    )
  end

  def index
  end

  def get_response
    response = $rhonda.text_request params["user_input"]
    # debugger
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
    elsif response[:result][:action] == "getSports"
      response = {
        "speech": "#{get_run.sample}"
      }
    else
        response = response[:result][:fulfillment]
    end
      render json: response
  end




end
