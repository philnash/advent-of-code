require "./days/day1"
require "./days/day2"
require "./days/day3"
require "./days/day4"
require "./days/day5"
require "./days/day6"
require "./days/day7"
require "./days/day8"
require "./days/day9"
require "./days/day10"
require "./days/day11"
require "./days/day12"

puts "--- Day 1: The Tyranny of the Rocket Equation ---"
input = File.read_lines("./days/day1.txt")
total_fuel = input.map { |mass_str| fuel_required(mass_str.to_i) }.sum
puts "Total fuel required is #{total_fuel}"
total_fuel = input.map { |mass_str| total_module_fuel_required(mass_str.to_i) }.sum
puts "Total fuel required including fuel for fuel is #{total_fuel}"

puts "--- Day 2: 1202 Program Alarm ---"
input = File.read("./days/day2.txt")
computer = Intcode2.new(input).initialize_memory(12,2)
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

puts "--- Day 6: Universal Orbit Map ---"
input = File.read_lines("./days/day6.txt")
orbit_map = OrbitMap.new(input)
puts "Number of direct and indirect orbits: #{orbit_map.check_sum}"
puts "Distance between you and san: #{orbit_map.distance_between("YOU", "SAN")}"

puts "--- Day 7: Amplification Circuit ---"
input = File.read("./days/day7.txt")
max_thruster_input, _ = AmplifierGroup.new(5).find_max_output(input)
puts "Highest signal to send to the thrusters: #{max_thruster_input}"
max_thruster_input_with_feedback, _ = AmplifierGroup.new(5).find_max_output_for_feedback_loop(input)
puts "Highest signal to send to the thrusters with feedback: #{max_thruster_input_with_feedback}"

puts "--- Day 8: Space Image Format ---"
input = File.read("./days/day8.txt")
sif = SIF.decode(input, 25, 6)
checksum = sif.checksum
puts "Checksum for image: #{checksum}"
puts "Image:"
sif.print_image

puts "--- Day 9: Sensor Boost ---"
input = File.read("./days/day9.txt")
computer = Intcode9::Computer.new(input)
puts computer.run([1_i64]).output
computer = Intcode9::Computer.new(input)
puts computer.run([2_i64]).output

puts "--- Day 10: Monitoring Station ---"
input = File.read("./days/day10.txt")
am = AsteroidMap.parse(input)
asteroid, count = am.most_asteroids_visible
puts "The best station is asteroid #{asteroid.x}, #{asteroid.y} with #{count} asteroids visible"
vaporized_200 = am.vaporized_at(200)
puts "The 200th vaporized asteroid is at #{vaporized_200.x}, #{vaporized_200.y}"

puts "--- Day 11: Space Police ---"
input = File.read("./days/day11.txt")
bot = EmergencyHullPaintingRobot.new(input)
puts bot.run.panels.size
bot = EmergencyHullPaintingRobot.new(input, [Panel.new(0, 0, Panel::Colour::White)])
bot.run.render

puts "--- Day 12: The N-Body Problem ---"
input = File.read_lines("./days/day12.txt")
moon_system = MoonSystem.new(input.map { |i| MoonSystem::Moon.parse(i) })
moon_system.step(1000)
puts "Total energy: #{moon_system.total_energy}"
moon_system = MoonSystem.new(input.map { |i| MoonSystem::Moon.parse(i) })
puts "Size of period: #{moon_system.find_system_period}"