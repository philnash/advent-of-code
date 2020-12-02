require "./days/*"

puts "--- Day 1: Report Repair ---"
input = File.read_lines("./days/day1.txt").map(&.to_i)
expenses = Expenses.new(input)
puts "The multiple of the pair that sum to 2020 is: #{expenses.multiple}"
puts "The multiple of the group of 3 that sum to 2020 is: #{expenses.multiple(3)}"

puts "--- Day 2: Password Philosophy ---"
input = File.read_lines("./days/day2.txt")
puts "The sled password policy has #{Policies.check(input, SledPolicy)} valid passwords"
puts "The toboggan password policy has #{Policies.check(input, TobogganPolicy)} valid passwords"
