require "./01/frequency"
require "./02/checksum.cr"

puts "--- Day 1: Chronal Calibration ---"
input = File.read_lines("./01/input.txt")
device = Device.new
device.update(input)
puts "Frequency result: #{device.frequency}"
device.find_duplicate(input)
puts "Frequency first duplicates at: #{device.duplicate}"

puts "--- Day 2: Inventory Management System ---"
input = File.read_lines("./02/input.txt")
collection = FabricBoxCollection.new(input)
puts "Checksum: #{collection.checksum}"
puts "Common letters: #{collection.find_close_id}"