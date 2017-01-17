module TvApi
  extend self

  def get_tv(show)
    total_episode = []
    tvdb = Tvdbr::Client.new('BFEEF9792B1697DF')
    episode = tvdb.find_all_series_by_title(show)
    output = ["#{episode[0].series_name}: #{episode[0].overview}."]
    Messagizer.messagize(output.first, '', '')
  end
end
