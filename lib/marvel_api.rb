module MarvelApi
  extend self

  def get_marvel(character)
    @client = Marvel::Client.new
    @client.configure do |config|
      config.api_key = 'a87a5938193d3e9dccc0f1f713fee785'
      config.private_key = '3e199647d1dc793129dc16q07e3c308ef2cfadb4'
    end
    response = @client.characters(nameStartsWith: character, orderBy: 'modified')
    @url = response.data.results[0].urls[0].url
    description = response.data.results[0].description
    debugger
  end

end
