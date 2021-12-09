class HeightMap
  @map : Array(Array(Int32))
  @height : Int32
  @width : Int32

  def initialize(input : Array(String))
    @map = input.map { |line| line.split("").map(&.to_i) }
    @width = @map.first.size
    @height = @map.size
  end

  def [](x, y)
    if x < 0 || x >= @width || y < 0 || y >= @height
      Int32::MAX
    else
      @map[y][x]
    end
  end

  def low_points
    points = Array({Int32, Int32, Int32}).new
    @map.each_with_index do |row, r_index|
      row.each_with_index do |col, c_index|
        point = @map[r_index][c_index]
        if self[c_index - 1, r_index] > point && self[c_index + 1, r_index] > point && self[c_index, r_index - 1] > point && self[c_index, r_index + 1] > point
          points.push({c_index, r_index, col})
        end
      end
    end
    points
  end

  def risk_level
    low_points = self.low_points.map { |p| p[2] }
    low_points.sum + low_points.size
  end

  def basins
    low_points = self.low_points.map { |p| {p[0], p[1]} }
    low_points.map do |(x, y)|
      basin = Set.new([{x, y}])
      new_points = [{x, y - 1}, {x, y + 1}, {x + 1, y}, {x - 1, y}].select { |(x, y)| x >= 0 && x < @width && y >= 0 && y <= @height }
      new_points.each do |(n_x, n_y)|
        next if basin.includes?({n_x, n_y}) || self[n_x, n_y] >= 9
        basin.add({n_x, n_y})
        next_points = [{n_x, n_y - 1}, {n_x, n_y + 1}, {n_x + 1, n_y}, {n_x - 1, n_y}].select { |(x, y)| !basin.includes?({x, y}) && x >= 0 && x < @width && y >= 0 && y < @height }
        new_points.concat(next_points)
      end
      basin
    end
  end

  def top_three_basins_product
    self.basins.map { |b| b.size }.sort.reverse.first(3).product
  end
end
