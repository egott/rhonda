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
      # logger.info 'does this work????????????????'
      # logger.info(query[:parameters]['recipe'])
      binding.pry
      if (query[:parameters]).has_key?(['recipe')
        logger.info("it has the keyyyyyyyyyyyyyyyy")
      else
        logger.info("it does not have the key :((((((((")
      end
  end


end
