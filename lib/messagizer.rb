module Messagizer
  extend self
  def messagize(output, url, giph)

    
            {
              "speech": output,
              "url": url,
              "giph": giph
            }

    end
end
