require "./days/*"

puts "--- Day 1: Sonar Sweep ---"
input = File.read_lines("./days/day1.txt").map(&.to_i)
sweep = SonarSweep.new(input)
puts "The number of depth increases is: #{sweep.count_increases}"
puts "The number of depth increases by groups is: #{sweep.count_window_increases}"

puts "--- Day 2: Dive! ---"
input = File.read_lines("./days/day2.txt")
sub = Dive.new
sub.apply_instructions(input)
puts "The position result it: #{sub.horizontal * sub.depth}"
sub = DiveWithAim.new
sub.apply_instructions(input)
puts "The position result it: #{sub.horizontal * sub.depth}"

puts "--- Day 3: Dive! ---"
input = File.read_lines("./days/day3.txt")
pc = PowerConsumption.new(input)
puts "The combined gamma and epsilon rates are: #{pc.rates}"
puts "The life support rating is #{pc.life_support_rating}"
