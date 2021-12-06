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

puts "--- Day 3: Binary Diagnostic ---"
input = File.read_lines("./days/day3.txt")
pc = PowerConsumption.new(input)
puts "The combined gamma and epsilon rates are: #{pc.rates}"
puts "The life support rating is #{pc.life_support_rating}"

puts "--- Day 4: Giant Squid ---"
input = File.read("./days/day4.txt")
game = Bingo::Game.new(input)
puts "The victorious game score is: #{game.play}"
puts "The last board to win score is: #{game.play_until_last_board_wins}"

puts "--- Day 5: Hydrothermal Venture ---"
input = File.read_lines("./days/day5.txt")
vents = Hydrothermal::Vents.new(input)
puts "The number of overlaps of verticals and horizontals is: #{vents.count_overlaps}"
vents = Hydrothermal::Vents.new(input)
puts "The number of overlaps of all lines is: #{vents.count_overlaps(true)}"

puts "--- Day 6: Lanternfish ---"
input = File.read("./days/day6.txt")
puts "The number of Lanternfish after 80 days is: #{School.new(input).add_days(80)}"
puts "The number of Lanternfish after 256 days is: #{School.new(input).add_days(256)}"
