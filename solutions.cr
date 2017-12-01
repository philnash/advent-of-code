require "./01-captcha/captcha"

puts "Day 1"
puts "====="
input = File.read("./01-captcha/input.txt")
puts "Captcha 1 result: #{Captcha.solve(input)}"
puts "Captcha 2 result: #{Captcha.solve_for_halfway(input)}"