class Xmas
  def initialize(@numbers : Array(Int64), @preamble_length = 25)
  end

  def valid?(number, previous_numbers)
    previous_numbers.combinations(2).map(&.sum).includes?(number)
  end

  def find_invalid_input
    previous_numbers = @numbers.first(@preamble_length)
    remaining = @numbers.skip(@preamble_length)
    remaining.each do |number|
      break number unless valid?(number, previous_numbers)
      previous_numbers.shift
      previous_numbers << number
    end
  end

  def find_encryption_weakness
    target = find_invalid_input
    return nil unless target
    @numbers.each_with_index do |number, index|
      set = [number]
      current_index = index
      while set.sum < target
        current_index += 1
        set << @numbers[current_index]
      end
      if set.sum == target
        break set.min + set.max
      end
    end
  end
end
