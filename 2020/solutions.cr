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

puts "--- Day 12: Rain Risk "
input = File.read("./days/day12.txt")
ship = Ship.new
puts "The ship travelled #{ship.travel(input)} by directions"
puts "Ths ship travelled #{ship.waypoint_travel(input)} by waypoint"
