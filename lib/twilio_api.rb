module TwilioApi
  extend self

  def sendGiph
    account_sid = "AC2edfac24f7c250a522984c5ef814d04e"
    auth_token = "{{ f7edb8354ee637670455902e8b4f1e8b }}"

    begin
      @client = Twilio::REST::Client.new account_sid, auth_token
      message = @client.account.messages.create(
        :from => '+16316511737',
        :to => '+19293417134',
        :body => 'Look at this fun giph 😀',
        )
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
    output = "I just sent this cool giph to Emily"
    Messagizer.messagize(output, '', '')
  end
end
