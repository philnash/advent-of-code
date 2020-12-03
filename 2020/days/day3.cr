class TobogganTrajectory
  getter width : Int32
  getter height : Int32
  getter map : Array(Array(String))

  def initialize(lines)
    @map = lines.map { |line| line.split("") }
    @width = @map.first.size
    @height = @map.size
  end

  def [](x, y)
    x = x % @width
    return @map[y][x]
  end

  def traverse(right, down)
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

  def test_paths(vectors)
    vectors.map { |vector| self.traverse(*vector).to_i64 }.product
  end
end
