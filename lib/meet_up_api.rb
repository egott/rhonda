module MeetUpApi
  extend self

  def get_meetup(category,location)
    loc = location.split(',')

    params = { category: get_category(category),
    city: loc[0].strip,
    state: loc[1].strip,
    radius: 10,
    country: 'US',
    status: 'upcoming',
    format: 'json',
    page: '50'}
    meetup_api = MeetupApi.new
    events = meetup_api.open_events(params)
    event = events["results"].sample
    output = "My suggestion would be to go to #{event["name"]} which is located at #{event["venue"]["address_1"]}, #{event["venue"]["zip"]} at #{Time.at(event["time"]/1000).strftime("%A %Y-%m-%d %l%P")}"
    Messagizer.messagize(output, "#{event['event_url']}", '')
  end

  def get_category(category)
    categories = [
      {id:1,name:"Arts & Culture"},
      {id:2,name:"Career & Business"},
      {id:3,name:"Cars & Motorcycles"},
      {id:4,name:"Community & Environment"},
      {id:5,name:"Dancing"},
      {id:6,name:"Education & Learning"},
      {id:8,name:"Fashion & Beauty"},
      {id:9,name:"Fitness"},
      {id:10,name:"Food & Drink"},
      {id:11,name:"Games"},
      {id:12,name:"LGBT"},
      {id:13,name:"Movements & Politics"},
      {id:14,name:"Health & Wellbeing"},
      {id:15,name:"Hobbies & Crafts"},
      {id:16,name:"Language & Ethnic Identity"},
      {id:17,name:"Lifestyle"},
      {id:18,name:"Book Clubs"},
      {id:20,name:"Movies & Film"},
      {id:21,name:"Music"},
      {id:22,name:"New Age & Spirituality"}
    ]
    arr = categories.select{|c|c[:name].include?(category)}
    arr[0][:id]
  end

end
