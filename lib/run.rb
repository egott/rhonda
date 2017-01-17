module Run
  extend self

  def get_run
    max_free_time = 0
    $last_arr.each do |answer|
      if answer[:hours_available] > max_free_time
        max_free_time = answer[:hours_available]
      end
    end

    runs = Run.where(duration: [0..(max_free_time * 60)])
      if runs.length > 0
        $runs = runs.sort_by { |run| run.duration}
        $run = $runs.pop
        duration = $run.duration
        calories = $run.calories
        fun_fact = $run.fun_fact_about_calories
        distance = $run.distance

        ouput = ["A great idea would be to run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]
      else
        output = ["You don't have time for a run today ☹️"]
      end
      return ouput
      Messagizer.messagize(ouput, '', '')
  end

end


# 
# def next_run
#   $run = $runs.pop
#   duration = $run.duration
#   calories = $run.calories
#   fun_fact = $run.fun_fact_about_calories
#   distance = $run.distance
#
#   ["You lazy piece of shit, run #{distance} miles for #{duration} minutes. You could burn #{calories} calories! If you do that, then #{fun_fact}", "Hmm fatass, how about a #{distance} mile run that burns around #{calories} calories for #{duration} minutes!" ]
# end


# elsif response[:result][:action] == 'getRun'
#   response = {
#     'speech': "#{get_run.sample}"
#   }
# elsif response[:result][:action] == 'nextRun'
#   response = {
#     'speech': "#{next_run.sample}"
#   }
