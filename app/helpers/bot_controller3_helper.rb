require 'eventful/api'

module BotController3Helper
  def get_run
    # debugger;
    run = Run.all.sample
    duration = run.duration
    calories = run.calories
    fun_fact = run.fun_fact_about_calories
    distance = run.distance

    ["A great idea would be to run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]
  end

  def get_event(subject, location)
    eventful = Eventful::API.new 'WZZ294GGCHG2rfjW'
    # debugger;
    results = eventful.call 'events/search',
                            :keywords => subject,
                            :location => location,
                            :page_size => 5
    event = results.first[1]['event'].sample
    ["There is an event at #{event['venue_name']}, on #{event['start_time']}. For more information, click here #{event['venue_url']}!",
    "I found an awesome event at #{event['venue_name']}. The event is on #{event['start_time']}, go here to learn more about it! #{event['venue_url']} 🤘"
  ]

  end

end
