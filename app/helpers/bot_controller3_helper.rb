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
end
