class MemoryGame
  def initialize(@starting_numbers : Array(Int32))
  end

  def turn(n)
    last_numbers = Hash(Int32, Int32).new
    @starting_numbers.each_with_index { |n, i| last_numbers[n] = i + 1 }
    current_number = 0
    (@starting_numbers.size + 1...n).each do |current_turn|
      next_number = last_numbers.has_key?(current_number) ? current_turn - last_numbers[current_number] : 0
      last_numbers[current_number] = current_turn
      current_number = next_number
    end
    current_number
  end
end
