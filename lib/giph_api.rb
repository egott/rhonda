module GiphApi
  extend self

  def get_giph(subject)
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{subject}"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    @giph = result['data']['image_url']

    Messagizer.messagize('', '', @giph)
  end

  def sendGiph
    account_sid = "AC2edfac24f7c250a522984c5ef814d04e"
    auth_token = "f7edb8354ee637670455902e8b4f1e8b"
    #Hardcoding numbers for now, because we can only send to verified numbers with the twilio trial account, if we have a pro account we would implement google contacts here so you can send it to everyone
    # Nadav = '+319096445'
    # Emily = '+18608787256'
    # Felix = '+19293417134'
    # Gibral = '+17183448481'

    begin
      @client = Twilio::REST::Client.new account_sid, auth_token
      message = @client.account.messages.create(:body => "Look at this fun giph 😀",
        :to => "+17183448481",
        :from => "+16316511737",
        :media_url => @giph
        )

    rescue Twilio::REST::RequestError => e
      puts e.message

    end
    output = "I just sent this cool giph to Gibral"
    Messagizer.messagize(output, '', '')
  end

end
