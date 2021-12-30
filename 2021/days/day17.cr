class Probe
  getter min_x : Int32
  getter min_y : Int32
  getter max_x : Int32
  getter max_y : Int32

  def initialize(input : String)
    match_data = input.match(/target area: x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/)
    if match_data
      @min_x = match_data[1].to_i
      @max_x = match_data[2].to_i
      @min_y = match_data[3].to_i
      @max_y = match_data[4].to_i
    else
      raise "Couldn't parse input"
    end
  end

  def shoot(x_vel, y_vel)
    location = {x: 0, y: 0}
    max_height = 0
    while (location[:x] < @max_x && location[:y] > @min_y)
      location = {x: location[:x] + x_vel, y: location[:y] + y_vel}
      x_vel = x_vel < 0 ? x_vel + 1 : (x_vel > 0 ? x_vel - 1 : 0)
      y_vel = y_vel - 1
      max_height = location[:y] if location[:y] > max_height
      break if location[:x] >= @min_x && location[:x] <= @max_x && location[:y] >= @min_y && location[:y] <= @max_y
    end
    {location[:x] >= @min_x && location[:x] <= @max_x && location[:y] >= @min_y && location[:y] <= @max_y, max_height}
  end

  def find_highest_path
    highest = 0
    @max_x.times do |x|
      (2*@min_y.abs).times do |y|
        result = self.shoot(x, y - @min_y.abs)
        highest = result[1] if result[0] && highest < result[1]
      end
    end
    highest
  end

  def find_all_vectors
    successes = 0
    (@max_x + 1).times do |x|
      (2*@min_y.abs).times do |y|
        result = self.shoot(x, y - @min_y.abs)
        successes += 1 if result[0]
      end
    end
    successes
  end
end
