class Ceiling
  struct Point
    property x : Int32
    property y : Int32
    property distance : Int32

    def initialize(@x, @y, @distance)
    end

    def update_distance(new_distance)
      @distance = [@distance, new_distance].min
    end
  end

  @map : Array(Array(Int32))
  @start : {Int32, Int32}
  @end : {Int32, Int32}
  @multiple : Int32

  def initialize(input : String, @multiple = 1)
    @map = input.split("\n").map { |row| row.split("").map(&.to_i) }
    @start = {0, 0}
    @end = {@map.first.size * @multiple - 1, @map.size * @multiple - 1}
  end

  def [](x, y)
    return nil if x < 0 || y < 0 || x > @end[0] || y > @end[1]
    orig_width = @map.first.size
    orig_height = @map.size
    if x < orig_width && y < orig_height
      @map[y][x]
    else
      orig_x = x % orig_width
      orig_y = y % orig_height
      orig_value = @map[orig_y][orig_x]
      result = (orig_value + x // orig_width + y // orig_height)
      return result > 9 ? result % 10 + 1 : result
    end
  end

  def to_s
    (@end[1] + 1).times do |y|
      row = ""
      (@end[0] + 1).times do |x|
        row += "#{self[x, y]}"
      end
      puts row
    end
  end

  def find_path
    unvisited = Array(Array(Int32)).new(@end[1] + 1)
    ((@end[1] + 1)*@multiple).times do |y|
      row = Array(Int32).new(@end[0] + 1)
      ((@end[0] + 1)*@multiple).times do |x|
        if x == 0 && y == 0
          row.push(0)
        else
          row.push(Int32::MAX // 2)
        end
      end
      unvisited.push(row)
    end
    visited = Set({x: Int32, y: Int32}).new
    to_test = Array({x: Int32, y: Int32, distance: Int32}).new
    to_test.push({x: 0, y: 0, distance: 0})
    while to_test.size > 0
      current = to_test.shift
      [
        {current[:x] - 1, current[:y], self[current[:x] - 1, current[:y]]},
        {current[:x] + 1, current[:y], self[current[:x] + 1, current[:y]]},
        {current[:x], current[:y] - 1, self[current[:x], current[:y] - 1]},
        {current[:x], current[:y] + 1, self[current[:x], current[:y] + 1]},
      ].reject { |point| point[2].nil? || visited.includes?({x: point[0], y: point[1]}) }.each do |(x, y, cost)|
        if cost
          new_distance = [unvisited[y][x], current[:distance] + cost].min
          if delete_index = to_test.index { |u| u == {x: x, y: y, distance: new_distance} }
            to_test.delete_at(delete_index)
          end
          if index = to_test.bsearch_index { |u| u[:distance] > new_distance }
            to_test.insert(index, {x: x, y: y, distance: new_distance})
          else
            to_test.push({x: x, y: y, distance: new_distance})
          end
          unvisited[y][x] = new_distance
        end
      end
      visited.add({x: current[:x], y: current[:y]})
      return current[:distance] if @end[0] == current[:x] && @end[1] == current[:y]
    end
  end
end
