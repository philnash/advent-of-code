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

puts "--- Day 4: ---"
input = File.read("./days/day4.txt")
puts PassportValidator.valid_passports(input)
puts PassportValidator.valid_passports(input, true)
