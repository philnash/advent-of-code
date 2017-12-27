require "./01-captcha/captcha"
require "./02-checksum/checksum"
require "./04-entropy/entropy"
require "./05-trampolines/trampolines"
require "./06-memory/memory"
require "./07-tower/tower"
require "./08-register/register"

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

puts "Day 4"
puts "====="
input = File.read_lines("./04-entropy/input.txt")
puts "Correct passphrases: #{Passphrase.count_valid_phrases(input)}"
puts "Correct anagram passphrases: #{AnagramPassphrase.count_valid_phrases(input)}"

puts "Day 5"
puts "====="
input = File.read("./05-trampolines/input.txt")
puts "Number of jumps: #{Offsets.jumps_until_out(input)}"
puts "Number of stranger jumps: #{Offsets.jumps_until_out(input, SometimesDecreasingPointerUpdater.new)}"

puts "Day 6"
puts "====="
input = File.read("./06-memory/input.txt").strip.split(/\s+/).map { |word| word.to_i }
memory = Memory.new(input)
memory.reallocate_until_optimal!
puts "Number of reallocations: #{memory.counter}"
puts "Length of reallocation loop: #{memory.reallocation_loop}"

puts "Day 7"
puts "====="
input = File.read("./07-tower/input.txt").strip
listing = ProgramListing.new
listing.parse(input)
program = listing.bottom_program
if program
  puts "Bottom program is #{program.name}"
  puts "Balancing weight is #{listing.balance(program)}"
end

puts "Day 8"
puts "====="
input = File.read("./08-register/input.txt").strip
register = Register.new
register.process_instructions(input)
puts "Register max value: #{register.max_register}"
puts "Register max historical value: #{register.max_historical_value}"
