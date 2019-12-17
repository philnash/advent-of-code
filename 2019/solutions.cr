require "./day1"

puts "--- Day 1: The Tyranny of the Rocket Equation ---"
input = File.read_lines("./day1.txt")
total_fuel = input.map { |mass_str| fuel_required(mass_str.to_i) }.sum
puts "Total fuel required is #{total_fuel}"
total_fuel = input.map { |mass_str| total_module_fuel_required(mass_str.to_i) }.sum
puts "Total fuel required including fuel for fuel is #{total_fuel}"