class TobogganTrajectory
  getter height : Int32
  getter map : Array(Array(String))
  getter width : Int32

  def initialize(lines)
    @map = lines.map { |line| line.split("") }
    @width = @map.first.size
    @height = @map.size - 1
  end

  def [](x, y)
    x = x % @width
    return @map[y][x]
  end

  def traverse(right, down)
    x = 0
    y = 0
    trees = 0
    while y < height
      x = x + right
      y = y + down
      trees += 1 if self[x, y] == "#"
    end
    trees
  end

  def test_paths(vectors)
    vectors.map { |vector| self.traverse(*vector).to_i64 }.product
  end
end
