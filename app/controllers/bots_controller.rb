class BotsController < ApplicationController
  def initialize
    $rhonda = ApiAiRuby::Client.new(
    :client_access_token => "25dbfde06b834782a5940ec803cfa275"
    )

  end

  def index
  end

  def create
    response = $rhonda.text_request bot_params
    render json:response
  end

end
