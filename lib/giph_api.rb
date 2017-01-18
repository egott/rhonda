module GiphApi
  extend self

  def get_giph(subject)
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{subject}"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    giph = result['data']['image_url']

    Messagizer.messagize('', '', giph)
  end

end
