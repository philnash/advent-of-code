require "./days/day1"
require "./days/day2"
require "./days/day3"
require "./days/day4"
require "./days/day5"

puts "--- Day 1: The Tyranny of the Rocket Equation ---"
input = File.read_lines("./days/day1.txt")
total_fuel = input.map { |mass_str| fuel_required(mass_str.to_i) }.sum
puts "Total fuel required is #{total_fuel}"
total_fuel = input.map { |mass_str| total_module_fuel_required(mass_str.to_i) }.sum
puts "Total fuel required including fuel for fuel is #{total_fuel}"

puts "--- Day 2: 1202 Program Alarm ---"
input = File.read("./days/day2.txt")
computer = Intcode.new(input).initialize_memory(12,2)
puts "Position 0 is #{computer.run.memory.first}"
puts "Noun and verb are: #{noun_and_verb_for_result(computer, 19690720)}"

puts "--- Day 3: Crossed Wires ---"
input = File.read_lines("./days/day3.txt")
puts "Closest point to origin is: #{find_closest_intersection(input[0], input[1])}"
puts "Closest intersect by distance travelled is: #{closest_intersection_by_distance_travelled(input[0], input[1])}"

puts "--- Day 4: Secure Container ---"
input = File.read("./days/day4.txt")
puts "Number of passwords: #{Password.count_passwords(input)}"
puts "Number of stricter passwords: #{Password.count_passwords_2(input)}"

puts "--- Day 5: Sunny with a Chance of Asteroids ---"
input = File.read("./days/day5.txt")
computer = Intcode5.new(input, 1)
puts computer.run.output
computer = Intcode5.new(input, 5)
puts computer.run.output