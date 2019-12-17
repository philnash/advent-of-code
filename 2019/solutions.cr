require "./days/day1"
require "./days/day2"

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

