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
  end

  class Vents
    @width : Int32
    @height : Int32
    @lines : Array(Line)

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
      map = (0..@height).to_a.map { Array(Int32).new(@width) { 0 } }
      lines = include_diagonals ? @lines : @lines.select { |line| line.start.x == line.finish.x || line.start.y == line.finish.y }
      lines.each do |line|
        if line.start.x == line.finish.x
          curr_y = line.start.y
          while curr_y < line.finish.y + 1
            map[line.start.x][curr_y] += 1
            curr_y += 1
          end
        elsif line.start.y == line.finish.y
          curr_x = line.start.x
          while curr_x < line.finish.x + 1
            map[curr_x][line.start.y] += 1
            curr_x += 1
          end
        else
          slope = (line.start.y - line.finish.y) / (line.start.x - line.finish.x)
          curr_x = line.start.x
          curr_y = line.start.y
          while curr_x != line.finish.x && curr_y != line.finish.y
            map[curr_x][curr_y] += 1
            curr_x += 1
            curr_y += slope > 0 ? 1 : -1
          end
        end
      end
      map.flatten.count { |i| i > 1 }
    end
  end
end
