require "./01/frequency"
require "./02/checksum.cr"
require "./03/claim.cr"
require "./04/guard.cr"
require "./05/polymer.cr"

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

puts "--- Day 3: No Matter How You Slice It ---"
input = File.read_lines("./03/input.txt")
collection = ClaimCollection.new
input.each do |claim_text|
  claim = Claim.parse(claim_text)
  collection.add(claim) if claim
end
puts "Duplicates: #{collection.duplicate_square_inches.size}"
puts "Intact Claim: #{collection.intact_claims.first.id}"

puts "--- Day 4: Repose Record ---"
input = File.read_lines("./04/input.txt")
guard_records = GuardRecord.parse_list(input)
guards = Guards.new
guards.create_from_guard_records(guard_records)
guard = guards.guards.sort_by { |guard| guard.minutes_asleep }.last
puts "Sleepiest guard: #{guard.id}. Sleepiest minute: #{guard.max_sleepy_minute[0]}."
guard = guards.guards.sort_by { |guard| guard.max_sleepy_minute[1] }.last
puts "Sleepiest guard: #{guard.id}. Sleepiest minute: #{guard.max_sleepy_minute[0]}."

puts "--- Day 5: Alchemical Reduction ---"
input = File.read("./05/input.txt")
result = Polymer.react(input)
puts "Length of polymer: #{result.size}"
puts "Best length after removing a unit type: #{Polymer.find_best(input).size}"
