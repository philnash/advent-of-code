require "./01/frequency"

puts "Day 1"
puts "====="
input = File.read_lines("./01/input.txt")
device = Device.new
device.update(input)
puts "Frequency result: #{device.frequency}"
device.find_duplicate(input)
puts "Frequency first duplicates at: #{device.duplicate}"