require "./01-captcha/captcha"
require "./02-checksum/checksum"

puts "Day 1"
puts "====="
input = File.read("./01-captcha/input.txt")
puts "Captcha 1 result: #{Captcha.solve(input)}"
puts "Captcha 2 result: #{Captcha.solve_for_halfway(input)}"

puts "Day 2"
puts "====="
input = File.read("./02-checksum/input.txt")
puts "Checksum 1 result: #{Checksum.calculate(input)}"
puts "Checksum 2 result: #{Checksum2.calculate(input)}"