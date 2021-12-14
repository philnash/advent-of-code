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

puts "--- Day 7: The Treachery of Whales ---"
input = File.read("./days/day7.txt")
puts "The fuel the crabs must use at a constant rate is: #{CrabSubmarines::ConstantFuelCost.new(input).fuel}"
puts "The fuel the crabs must use at an increasing rate is: #{CrabSubmarines::IncreasingFuelCost.new(input).fuel}"

puts "--- Day 8: Seven Segment Search ---"
input = File.read_lines("./days/day8.txt")
puts "The number of ones, fours, sevens and eights is: #{SegmentSearch.unique_output_segment_count(input)}"
puts "The combined total of the outputs is: #{SegmentSearch.sum_outputs(input)}"

puts "--- Day 9: Smoke Basin ---"
input = File.read_lines("./days/day9.txt")
height_map = HeightMap.new(input)
puts "The total risk level is: #{height_map.risk_level}"
puts "The product of the largest three basins is: #{height_map.top_three_basins_product}"

puts "--- Day 10: Syntax Scoring ---"
input = File.read_lines("./days/day10.txt")
puts "The total score for syntax errors is: #{SyntaxChecker.score_errors(input)}"
puts "The middle score for the completed rows is: #{SyntaxChecker.score_completions(input)}"

puts "--- Day 11: Dumbo Octopus ---"
input = File.read_lines("./days/day11.txt").map { |row| row.split("").map(&.to_i) }
grid = OctopusGrid.new(input)
puts "The number of octopus flashes after 100 steps is: #{grid.step(100)}"
puts "The number of steps it takes to all flash at the same time is: #{100 + grid.step_until_synchronised}"

puts "--- Day 12: Passage Pathing ---"
input = File.read_lines("./days/day12.txt")
caves = CaveSystem.new(input)
puts "The number of paths through the system is: #{caves.traverse.size}"
puts "The number of paths through the system where you can visit one small cave more than once is: #{caves.extended_traverse.size}"

puts "--- Day 13:  ---"
input = File.read("./days/day13.txt")
code_page = CodePage.new(input)
code_page.fold
puts "The number of dots after one fold is: #{code_page.dots.size}"
code_page.finish_folding
puts "The code is:\n#{code_page.to_s}"
