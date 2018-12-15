class Sky
  getter points : Array(Point)
  getter min_x : Int32
  getter max_x : Int32
  getter min_y : Int32
  getter max_y : Int32

  def initialize(@points = [] of Point)
    @min_x = @points.map(&.x).min
    @max_x = @points.map(&.x).max
    @min_y = @points.map(&.y).min
    @max_y = @points.map(&.y).max
  end

  def add(point : Point)
    @points.push(point)
  end

  def draw
    (@min_y..@max_y).map do |row|
      (@min_x..@max_x).map do |col|
        if @points.find { |p| p.x == col && p.y == row }
          "#"
        else
          "."
        end
      end.join("")
    end.join("\n")
  end


  def tick
    @points.each &.update!
    @min_x = @points.map(&.x).min
    @max_x = @points.map(&.x).max
    @min_y = @points.map(&.y).min
    @max_y = @points.map(&.y).max
  end
end

class Point
  getter position : Tuple(Int32, Int32)
  getter velocity : Tuple(Int32, Int32)

  def self.parse(text)
    position_match = text.match(/^position=<\s?(-?\d+), \s?(-?\d+)/)
    velocity_match = text.match(/velocity=<\s?(-?\d+), \s?(-?\d+)>$/)
    if position_match && velocity_match
      Point.new({position_match[1].to_i, position_match[2].to_i}, {velocity_match[1].to_i, velocity_match[2].to_i})
    else
      raise "Could not find a positiona and a velocity in '#{text}'"
    end
  end

  def initialize(@position, @velocity)
  end

  def update!
    @position = {position[0] + velocity[0], position[1] + velocity[1]}
  end

  def x
    @position[0]
  end

  def y
    @position[1]
  end
end