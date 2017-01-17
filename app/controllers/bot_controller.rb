class BotController < ApplicationController
  def index
    $rhonda = ApiAiRuby::Client.new(
    :client_access_token => "21136391b2cd47d7bbf7e5f7813287dc"
    )
  end

  def get_response
    ai_response = $rhonda.text_request params["user_input"]
     response = Response.api_distr(ai_response, current_user)



    # elsif response[:result][:action] == "getFreetime"
    #   response =
    #       {
    #         "speech": "#{get_freetime}"
    #       }


    # elsif response[:result][:action] == 'setRun'
    #   time = response[:result][:parameters][:time]
    #   response = {
    #     'speech': "#{set_run(time)}"
    #   }
  
    #     response = response[:result][:fulfillment]
    # end

      render json: response
  end

end
