module Captcha
  def self.solve(input : String)
    characters = input.split("")
    numbers = characters.map { |c| c.to_i }
    pairs = numbers.dup
    first_number = pairs.shift
    pairs << first_number
    number_pairs = numbers.zip(pairs)
    number_pairs.reduce(0) { |acc, pair| pair[0] == pair[1] ? acc + pair[0] : acc }
  end
end