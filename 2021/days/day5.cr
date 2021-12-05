module Hydrothermal
  class Point
    getter x : Int32
    getter y : Int32

    def initialize(@x, @y)
    end
  end

  class Line
    getter start : Point
    getter finish : Point

    def initialize(a : Point, b : Point)
      if a.x == b.x
        @start = a.y < b.y ? a : b
        @finish = a.y < b.y ? b : a
      else
        @start = a.x < b.x ? a : b
        @finish = a.x < b.x ? b : a
      end
    end

    def includes?(x : Int32, y : Int32)
      if @start.x == x && @start.y == y || @finish.x == x && @finish.y == y
        return true
      elsif @start.x == @finish.x
        return x == @start.x && y >= @start.y && y <= @finish.y
      elsif @start.y == @finish.y
        return y == @start.y && x >= @start.x && x <= @finish.x
      else
        slope = (@start.y - @finish.y) / (@start.x - @finish.x)
        in_bound = x >= @start.x && x <= @finish.x && (slope < 0 ? y <= @start.y && y >= @finish.y : y >= @start.y && y <= @finish.y)
        return ((@start.y - y) / (@start.x - x) == slope) && in_bound
      end
    end
  end

  class Vents
    getter lines : Array(Line)
    @width : Int32
    @height : Int32

    def initialize(input : Array(String))
      @lines = input.map do |coords|
        match_data = coords.match(/^(\d+),(\d+) -> (\d+),(\d+)$/)
        if match_data
          Line.new(Point.new(match_data[1].to_i, match_data[2].to_i), Point.new(match_data[3].to_i, match_data[4].to_i))
        end
      end.compact
      @width = @lines.map { |line| [line.start.x, line.finish.x].max }.max + 1
      @height = @lines.map { |line| [line.start.y, line.finish.y].max }.max + 1
    end

    def count_overlaps(include_diagonals = false)
      lines = include_diagonals ? @lines : @lines.select { |line| line.start.x == line.finish.x || line.start.y == line.finish.y }
      overlaps = 0
      @height.times do |row|
        @width.times do |col|
          overlaps += 1 if lines.count { |line| line.includes?(col, row) } > 1
        end
      end
      overlaps
    end
  end
end
