require "./days/*"

puts "--- Day 1: Report Repair ---"
input = File.read_lines("./days/day1.txt").map(&.to_i)
expenses = Expenses.new(input)
puts "The multiple of the pair that sum to 2020 is: #{expenses.multiple}"
puts "The multiple of the group of 3 that sum to 2020 is: #{expenses.multiple(3)}"

puts "--- Day 2: Password Philosophy ---"
input = File.read_lines("./days/day2.txt")
puts "The sled password policy has #{Passwords.check(input, SledPolicy)} valid passwords"
puts "The toboggan password policy has #{Passwords.check(input, TobogganPolicy)} valid passwords"

puts "--- Day 3: Toboggan Trajectory ---"
input = File.read_lines("./days/day3.txt")
map = TobogganTrajectory.new(input)
puts "You would encounter #{map.traverse(3, 1)} trees in part 1"
puts "The product of the trees encountered over different paths is #{map.test_paths([{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}])}"

puts "--- Day 4: Passport Processing ---"
input = File.read("./days/day4.txt")
puts "There are #{PassportValidator.valid_passports(input)} valid passports"
puts "There are #{PassportValidator.valid_passports(input, true)} valid passports with valid data"

puts "--- Day 5: Binary Boarding ---"
input = File.read_lines("./days/day5.txt")
seats = Seats.new(input)
puts "The highest seat id is #{seats.highest_id}"
puts "My seat is #{seats.missing_seat}"

puts "--- Day 6: Custom Customs ---"
input = File.read("./days/day6.txt")
puts "The sum of questions where anyone answered 'yes' is #{FamilyGroup.any_yes(input)}"
puts "The sum of questions where everyone answered 'yes' is #{FamilyGroup.every_yes(input)}"

puts "--- Day 7: Handy Haversacks ---"
input = File.read_lines("./days/day7.txt")
collection = BagCollection.parse(input)
shiny_gold = collection.find("shiny gold")
puts "The number of bag colours that can contain a shiny gold bag is #{shiny_gold.containers}"
puts "The number of bags required inside a shiny gold bag is #{shiny_gold.all_children}"

puts "--- Day 8: Handheld Halting ---"
input = File.read_lines("./days/day8.txt")
console = Console.new
puts "The accumulator before the program loops is: #{console.process_instructions(input)[0]}"
puts "The accumulator for the correct program is: #{console.find_incorrect_instruction(input)}"

puts "--- Day 9: Encoding Error ---"
input = File.read_lines("./days/day9.txt").map(&.to_i64)
xmas = Xmas.new(input)
puts "The number that is not a sum is: #{xmas.find_invalid_input}"
puts "The encryption weakness is #{xmas.find_encryption_weakness}"

puts "--- Day 10: Adapter Array ---"
input = File.read_lines("./days/day10.txt").map(&.to_i)
adapters = JoltAdapters.new(input)
puts "The multiple of the differences is: #{adapters.difference_multiple}"
puts "The total number of possible connections is: #{adapters.all_connections}"

puts "--- Day 11: Seating System ---"
input = File.read("./days/day11.txt")
seats = WaitingSeats.new(input)
seats.cycle_part_1_until_stable
puts "There are #{seats.occupied_seats} occupied seats when stable under part 1 rules"

seats = WaitingSeats.new(input)
seats.cycle_part_2_until_stable
puts "There are #{seats.occupied_seats} occupied seats when stable under part 2 rules"

puts "--- Day 12: Rain Risk ---"
input = File.read("./days/day12.txt")
ship = Ship.new
puts "The ship travelled #{ship.travel(input)} by directions"
puts "Ths ship travelled #{ship.waypoint_travel(input)} by waypoint"

puts "--- Day 13: Shuttle Search ---"
input = File.read("./days/day13.txt")
timetable = Timetable.parse_timetable(input)
puts "The earliest bus after the time is: #{timetable.earliest_bus}"
puts "The time at which the buses take off in order is: #{Timetable.win_gold_coin(input.split("\n")[1])}"

puts "--- Day 14: Docking Data ---"
input = File.read_lines("./days/day14.txt")
puts "V1 memory sum: #{DockingProgram::V1.run_program(input)}"
puts "V2 memory sum: #{DockingProgram::V2.run_program(input)}"

puts "--- Day 15: Rambunctious Recitation ---"
input = File.read("./days/day15.txt")
game = MemoryGame.new(input.split(",").map(&.to_i))
puts "The 2020th number is #{game.turn(2020)}"
puts "The 30000000th number is #{game.turn(30000000)}"

puts "--- Day 16: Ticket Translation ---"
input = File.read("./days/day16.txt")
rules = Ticket.parse_rules(input)
nearby_tickets = Ticket.parse_nearby_tickets(input, rules)
my_ticket = Ticket.parse_my_ticket(input)
puts "The sum of the invalid tickets is: #{Ticket.invalid_tickets_sum(nearby_tickets)}"
labels = Ticket.labels(nearby_tickets, rules)
puts "The product of the departure values is: #{Ticket.departure_product(my_ticket, labels)}"

puts "--- Day 17: Conway Cubes ---"
input = File.read("./days/day17.txt")
cubes = ConwayCubes.new(input)
6.times { cubes.cycle }
puts "There are #{cubes.count} active 3D cubes"
cubes = ConwayCubes4D.new(input)
6.times { cubes.cycle }
puts "There are #{cubes.count} active 4D cubes"

puts "--- Day 18: Operation Order ---"
input = File.read_lines("./days/day18.txt")
puts "Sum with no precendence: #{input.map { |exp| WrongMaths::V1.calculate(exp) }.reject(Nil).sum}"
puts "Sum with opposite precedence: #{input.map { |exp| WrongMaths::V2.calculate(exp) }.reject(Nil).sum}"

puts "--- Day 19: Monster Messages ---"
input = File.read("./days/day19.txt").split("\n\n")
sat = SatelliteRegexes.new(input[0])
puts input[1].split("\n").count { |str| sat.test(str) }
sat = SatelliteRegexes.new(input[0], 2)
puts input[1].split("\n").count { |str| sat.test(str) }
