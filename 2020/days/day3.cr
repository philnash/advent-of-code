class TobogganTrajectory
  getter width : Int32
  getter height : Int32
  getter map : Array(Array(String))

  def initialize(lines : Array(String))
    @map = lines.map { |line| line.split("") }
    @width = @map.first.size
    @height = @map.size
  end

  def [](x, y)
    @map[y][x % @width]
  end

  def traverse(right : Int32, down : Int32)
    x = right
    y = down
    trees = 0
    while y < height
      trees += 1 if self[x, y] == "#"
      x = x + right
      y = y + down
    end
    trees
  end

  def test_paths(vectors : Array(Tuple(Int32, Int32))) : Int64
    vectors.map { |vector| self.traverse(*vector).to_i64 }.product
  end
end
