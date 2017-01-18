class BotController < ApplicationController
  def index
  end

  def get_response
    ai_response = $rhonda.text_request params["user_input"]
    response = Response.api_distr(ai_response, current_user)

      render json: response
  end

end
