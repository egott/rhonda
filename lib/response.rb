module Response
  extend self
  require 'net/http'
  require 'json'
  require 'uri'

  def api_distr(response)
    case response[:result][:action]
    when "getRecipe"
      @ingredient = response[:result][:parameters][:food]
      RecipeApi.get_recipe(@ingredient)
    when "nextRecipe"
      RecipeApi.get_recipe(@ingredient)
    when "getAPIevent"
      @api_event_subject = response[:result][:parameters][:'APIevent-subject']
      @api_event_location = response[:result][:parameters][:'api_event_location']
      EventfulApi.get_event(@api_event_subject, @api_event_location)
    when "nextEvent"
      EventfulApi.get_event(@api_event_subject, @api_event_location)
    when "getGiph"
      @subject = response[:result][:parameters][:giphSubject]
      GiphApi.get_giph(@subject)
    when "nextGiph"
      GiphApi.get_giph(@subject)
    end

  end


end
