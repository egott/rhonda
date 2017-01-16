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


    elsif response[:result][:action] == "setEvent"
      title = response[:result][:parameters][:eventtitle]
      puts title
      if title == ""
        title = "event"
      end

      location = response[:result][:parameters][:eventlocation]
      day = response[:result][:parameters][:eventstart]
      starttime = response[:result][:parameters][:eventtime].join.split[0..1]
      endtime = response[:result][:parameters][:eventtime].join.split[-2..-1]


      response = {
        "speech": "#{set_event(title, location, day, starttime, endtime)}"
        }

    elsif response[:result][:action] == "getAPIevent"
      # binding.pry
      $api_event_subject = response[:result][:parameters][:'APIevent-subject']
      $api_event_location = response[:result][:parameters][:'api_event_location']

      response = {
        'speech': "#{get_event($api_event_subject, $api_event_location).sample}"
      }
    elsif response[:result][:action] == "nextEvent"
      response = {
        'speech': "#{get_event($api_event_subject, $api_event_location).sample}"
      }
    else
        response = response[:result][:fulfillment]
    end
      render json: response
  end




end
