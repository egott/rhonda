# module FreeTime
#   extend self
#
#   def calculate_freetime(calendar_events)
#     full_day = {}
#     (0..24).each do |i|
#       full_day[i] = true
#     end
#     calendar_events.data.items.each do |event|
#       full_day[event.start.dateTime.hour] = false
#     end
#     full_day
#   end
#
# end
#
#
# def calculate_freetime(calendar_events)
#   full_day = {}
#   (0..24).each do |i|
#     full_day[i] = true
#   end
#   calendar_events.data.items.each do |event|
#     full_day[event.start.dateTime.hour] = false
#   end
#   full_day
# end
#
# def group_open_times(free_time)
#   Time.zone = 'EST'
#   start_date = Time.now.hour
#   end_date = Time.now.end_of_day.hour
#   group_of_hours = []
#   final_group_of_hours = []
#   num_of_hours = 0
#   (start_date..end_date).step(1) do |i|
#     if free_time[i]
#       group_of_hours << i
#     else
#       final_group_of_hours << group_of_hours
#       group_of_hours = []
#     end
#   end
#   final_group_of_hours << group_of_hours
#   final_group_of_hours.delete_if {|x| x.empty?}
#   last_arr = []
#   final_group_of_hours.each do |groups|
#     freetime = {
#       hours_available: groups.length,
#       hour_start: groups.first
#     }
#     last_arr << freetime
#   end
#   return last_arr
# end
