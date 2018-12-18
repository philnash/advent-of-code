require "./01/frequency"
require "./02/checksum.cr"
require "./03/claim.cr"
require "./04/guard.cr"
require "./05/polymer.cr"
require "./06/coordinates.cr"
require "./07/step.cr"
require "./08/tree.cr"
require "./09/marbles.cr"
require "./10/messages.cr"
require "./11/fuel.cr"

require "./14/recipe.cr"

require "./18/lumber.cr"

# puts "--- Day 1: Chronal Calibration ---"
# input = File.read_lines("./01/input.txt")
# device = Device.new
# device.update(input)
# puts "Frequency result: #{device.frequency}"
# device.find_duplicate(input)
# puts "Frequency first duplicates at: #{device.duplicate}"

# puts "--- Day 2: Inventory Management System ---"
# input = File.read_lines("./02/input.txt")
# collection = FabricBoxCollection.new(input)
# puts "Checksum: #{collection.checksum}"
# puts "Common letters: #{collection.find_close_id}"

# puts "--- Day 3: No Matter How You Slice It ---"
# input = File.read_lines("./03/input.txt")
# collection = ClaimCollection.new
# input.each do |claim_text|
#   claim = Claim.parse(claim_text)
#   collection.add(claim) if claim
# end
# puts "Duplicates: #{collection.duplicate_square_inches.size}"
# puts "Intact Claim: #{collection.intact_claims.first.id}"

# puts "--- Day 4: Repose Record ---"
# input = File.read_lines("./04/input.txt")
# guard_records = GuardRecord.parse_list(input)
# guards = Guards.new
# guards.create_from_guard_records(guard_records)
# guard = guards.guards.sort_by { |guard| guard.minutes_asleep }.last
# puts "Sleepiest guard: #{guard.id}. Sleepiest minute: #{guard.max_sleepy_minute[0]}."
# guard = guards.guards.sort_by { |guard| guard.max_sleepy_minute[1] }.last
# puts "Sleepiest guard: #{guard.id}. Sleepiest minute: #{guard.max_sleepy_minute[0]}."

# puts "--- Day 5: Alchemical Reduction ---"
# input = File.read("./05/input.txt")
# result = Polymer.react(input)
# puts "Length of polymer: #{result.size}"
# puts "Best length after removing a unit type: #{Polymer.find_best(input).size}"

# puts "--- Day 6: Chronal Coordinates ---"
# input = File.read_lines("./06/input.txt")
# coordinates = input.map { |line| line.split(/,\s+/).map { |string| string.to_i }}.map { |(x,y)| Coordinate.new(x,y) }
# grid = Grid.new(coordinates)
# puts "Greatest finite area is: #{grid.greatest_finite_area} in size"
# puts "Region within 10000 is: #{grid.region_within(10000)}"

# puts "--- Day 7: The Sum of Its Parts ---"
# input = File.read_lines("./07/input.txt")
# Step.parse_lines(input)
# puts "The order of building is: #{Step.build}"
# Step.reset
# Step.parse_lines(input, 60)
# puts "The time for the parallel build is: #{Step.build_in_parallel(5)}"

# puts "--- Day 8: Memory Maneuver ---"
# input = File.read("./08/input.txt")
# index, node = Tree.parse(input)
# puts "The total metadata for the nodes is: #{node.metadata_total}"
# puts "The total value for the nodes is: #{node.value}"

# puts "--- Day 9: Marble Mania ---"
# game = Game.new(71940.to_i64, 465)
# puts "The high score is: #{game.play}"
# game2 = Game.new((71940*100).to_i64, 465)
# puts "The high score is: #{game2.play}"
# require "./05/polymer.cr"
# require "./06/coordinates.cr"
# require "./07/step.cr"
# require "./08/tree.cr"
# require "./09/marbles.cr"
# require "./10/messages.cr"

# require "./14/recipe.cr"

# puts "--- Day 1: Chronal Calibration ---"
# input = File.read_lines("./01/input.txt")
# device = Device.new
# device.update(input)
# puts "Frequency result: #{device.frequency}"
# device.find_duplicate(input)
# puts "Frequency first duplicates at: #{device.duplicate}"

# puts "--- Day 2: Inventory Management System ---"
# input = File.read_lines("./02/input.txt")
# collection = FabricBoxCollection.new(input)
# puts "Checksum: #{collection.checksum}"
# puts "Common letters: #{collection.find_close_id}"

# puts "--- Day 3: No Matter How You Slice It ---"
# input = File.read_lines("./03/input.txt")
# collection = ClaimCollection.new
# input.each do |claim_text|
#   claim = Claim.parse(claim_text)
#   collection.add(claim) if claim
# end
# puts "Duplicates: #{collection.duplicate_square_inches.size}"
# puts "Intact Claim: #{collection.intact_claims.first.id}"

# puts "--- Day 4: Repose Record ---"
# input = File.read_lines("./04/input.txt")
# guard_records = GuardRecord.parse_list(input)
# guards = Guards.new
# guards.create_from_guard_records(guard_records)
# guard = guards.guards.sort_by { |guard| guard.minutes_asleep }.last
# puts "Sleepiest guard: #{guard.id}. Sleepiest minute: #{guard.max_sleepy_minute[0]}."
# guard = guards.guards.sort_by { |guard| guard.max_sleepy_minute[1] }.last
# puts "Sleepiest guard: #{guard.id}. Sleepiest minute: #{guard.max_sleepy_minute[0]}."

# puts "--- Day 5: Alchemical Reduction ---"
# input = File.read("./05/input.txt")
# result = Polymer.react(input)
# puts "Length of polymer: #{result.size}"
# puts "Best length after removing a unit type: #{Polymer.find_best(input).size}"

# puts "--- Day 6: Chronal Coordinates ---"
# input = File.read_lines("./06/input.txt")
# coordinates = input.map { |line| line.split(/,\s+/).map { |string| string.to_i }}.map { |(x,y)| Coordinate.new(x,y) }
# grid = Grid.new(coordinates)
# puts "Greatest finite area is: #{grid.greatest_finite_area} in size"
# puts "Region within 10000 is: #{grid.region_within(10000)}"

# puts "--- Day 7: The Sum of Its Parts ---"
# input = File.read_lines("./07/input.txt")
# Step.parse_lines(input)
# puts "The order of building is: #{Step.build}"
# Step.reset
# Step.parse_lines(input, 60)
# puts "The time for the parallel build is: #{Step.build_in_parallel(5)}"

# puts "--- Day 8: Memory Maneuver ---"
# input = File.read("./08/input.txt")
# index, node = Tree.parse(input)
# puts "The total metadata for the nodes is: #{node.metadata_total}"
# puts "The total value for the nodes is: #{node.value}"

# puts "--- Day 9: Marble Mania ---"
# game = Game.new(71940.to_i64, 465)
# puts "The high score is: #{game.play}"
# game2 = Game.new((71940*100).to_i64, 465)
# puts "The high score is: #{game2.play}"

# puts "--- Day 10: The Stars Align ---"
# input = File.read_lines("./10/input.txt")
# points = input.map { |line| Point.parse(line) }
# sky = Sky.new(points)
# puts "Width: #{sky.max_x - sky.min_x}. Height: #{sky.max_y - sky.min_y}"
# 10159.times { sky.tick }
# puts sky.draw

# puts "--- Day 11: Chronal Charge ---"
# p1 = PowerGrid.new(8561)
# puts "Highest powered subgrid is at point: #{p1.get_highest_subgrid(3)[0]}"
# puts p1.get_highest_subgrid_and_size


# puts "\nCome back to the other days\n\n"

# puts "--- Day 14: Chocolate Charts ---"
# input = File.read("./14/input.txt")
# puts "The next 10 scores after #{input} are: #{Recipe.next_ten(input)}"
# puts "The position for the pattern #{input} is #{Recipe.how_many_to_score(input)}"


puts "--- Day 18: Settlers of The North Pole ---"
input = File.read("./18/input.txt")
landscape = Landscape.parse(input)
landscape = landscape.tick(10)
puts "The total resource value after 10 minutes is: #{landscape.total}"
landscape = Landscape.parse(input)
landscape = landscape.tick(1_000_000_000)
puts "The total resource value after 1000000000 minutes is: #{landscape.total}"