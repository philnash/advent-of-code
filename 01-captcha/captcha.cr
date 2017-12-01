module Captcha
  def self.solve(input : String, shift = 1)
    characters = input.split("")
    numbers = characters.map { |c| c.to_i }
    length = numbers.size
    acc = 0
    numbers.each_with_index do |number, index|
      acc += number if number == numbers[(index+shift).modulo(length)]
    end
    return acc
  end

  def self.solve_for_halfway(input : String)
    solve(input, input.size/2)
  end
end