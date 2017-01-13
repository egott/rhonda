class BotsController < ApplicationController
  def initialize
    $rhonda = ApiAiRuby::Client.new(
    :client_access_token => "21136391b2cd47d7bbf7e5f7813287dc"
    )
  end

  def index
  end

  # def get_response
  #   response = $rhonda.text_request params[:user_input]
  #   render json:response
  # end


  def get_recipe
      query = params[:result]
      logger.info(query)
      render json: response
  end


end
