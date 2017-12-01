module Captcha
  def self.solve(input : String, offset = 1)
    numbers = input.split("").map { |c| c.to_i }
    size = numbers.size
    acc = numbers.reduce({0, 0}) do |acc, number|
      total = number == numbers[(acc[1]+offset).modulo(size)] ? acc[0] + number : acc[0]
      {total, acc[1]+1}
    end
    return acc[0]
  end

  def self.solve_for_halfway(input : String)
    solve(input, input.size/2)
  end
end