class Coordinate
  getter x : Int32
  getter y : Int32

  def initialize(@x, @y)
  end

  def manhattan_distance(other_x, other_y)
    (@x - other_x).abs + (@y - other_y).abs
  end

  def manhattan_distance(coord : Coordinate)
    manhattan_distance(coord.x, coord.y)
  end
end


class Grid
  getter coords : Array(Coordinate)
  getter origin_x : Int32
  getter origin_y : Int32
  getter width : Int32
  getter height : Int32

  def initialize(@coords)
    xs = @coords.map { |c| c.x }
    @origin_x = xs.min - 1
    @width = xs.max - xs.min + 2

    ys = @coords.map { |c| c.y }
    @origin_y = ys.min - 1
    @height = ys.max - ys.min + 2
  end

  def distances_to_point(row, col)
    @coords.map { |c| c.manhattan_distance(row, col) }
  end

  def [](row, col) : Coordinate | Nil
    coord = @coords.find { |c| c.x == row && c.y == col }
    return coord if coord
    distances = distances_to_point(row, col)
    min = distances.index(distances.min)
    if distances.count(distances.min) > 1
      return nil
    else
      return @coords[min] if min
    end
  end

  def greatest_finite_area
    infinite_areas = Set.new([] of Coordinate)
    finite_areas = Hash(Coordinate, Int32).new(0)
    (@origin_y..@origin_y + @height).each do |row|
      (@origin_x..@origin_x+@width).each do |col|
        coord = self[row, col]
        if coord
          if row == @origin_y || row == @origin_y + @height || col == @origin_x || col == @origin_x + @width
            infinite_areas.add(coord)
            finite_areas.delete(coord)
          else
            finite_areas[coord] += 1
          end
        end
      end
    end
    finite_areas.values.max
  end

  def region_within(total_distance)
    total = 0
    (@origin_y..@origin_y + @height).each do |row|
      (@origin_x..@origin_x+@width).each do |col|
        total += 1 if distances_to_point(row, col).sum < total_distance
      end
    end
    total
  end

end