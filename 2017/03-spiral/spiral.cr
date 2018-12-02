#
# 37  36  35  34  33  32  31
# 38  17  16  15  14  13  30
# 39  18   5   4   3  12  29
# 40  19   6   1   2  11  28
# 41  20   7   8   9  10  27
# 42  21  22  23  24  25  26
# 43  44  45  46  47  48  49 50
#                            81
# Bottom right hand corner is odd squares
# (2n - 1)^2

# spiral_level: 2. first: 2 (1**2 + 1)     2 ==> 1 (level-1)*2 -1
# spiral_level: 3. first: 10 (3**2 + 1)    3 ==> 3
# spiral_level: 4. first: 26 (5**2 + 1)    4 ==> 5
# spiral_level: 5. first: 50 (7**2 + 1)    5 ==> 7


module Spiral
  def self.distance(square : Int32)
    return 0 if square == 1
    spiral_level = level(square)
    max_in_spiral = (2*spiral_level-1)**2
    number_in_side = 2*spiral_level-2
    min_in_side = ((spiral_level-1)*2 - 1)**2 + 1
    while ((square - min_in_side) > number_in_side)
      min_in_side = min_in_side + number_in_side
    end
    min = spiral_level-1
    return min + (square - min_in_side - (spiral_level-2)).abs
  end

  def self.level(square : Int32)
    level = 1
    while (((2*level - 1)**2) < square)
      level = level + 1
    end
    return level
  end
end

# level 1: 1
# level 2: 8
# level 3: 16
# level 4: 24
# level 5: 32

class NeighbourSpiral
  def initialize(@level : Int32)

  end

  def list
    if @level == 1
      return [1]
    else
      array = Array.new((@level-1)*8, 0)
      prev_spiral = NeighbourSpiral.new(@level-1)
      array.map do |item|

      end
      return array
    end
  end
end

puts NeighbourSpiral.new(3).list