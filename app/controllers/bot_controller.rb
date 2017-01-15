class BotController < ApplicationController
  include BotControllerHelper
  include BotControllerHelper2
  include BotController3Helper

  def index
    $rhonda = ApiAiRuby::Client.new(
    :client_access_token => "21136391b2cd47d7bbf7e5f7813287dc"
    )
  end

  def get_response
    response = $rhonda.text_request params["user_input"]

    if response[:result][:action] == "getRecipe"
      $ingredient = response[:result][:parameters][:food]
      response =
              {
                "speech": "#{get_recipe($ingredient).sample}"
              }
    elsif response[:result][:action] == "nextRecipe"
      response =
          {
            "speech": "#{get_recipe($ingredient).sample}"
          }

    elsif response[:result][:action] == "getFreetime"
      response =
          {
            "speech": "#{get_freetime}"
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
