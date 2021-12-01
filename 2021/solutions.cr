require "./days/*"

puts "--- Day 1: Sonar Sweep ---"
input = File.read_lines("./days/day1.txt").map(&.to_i)
sweep = SonarSweep.new(input)
puts "The number of depth increases is: #{sweep.count_increases}"
puts "The number of depth increases by groups is: #{sweep.count_window_increases}"
