class Asteroid
  getter x : Int32
  getter y : Int32
  def initialize(@x, @y)
  end
end

class AsteroidMap
  getter asteroids : Array(Asteroid)

  def self.parse(map)
    asteroids = [] of Asteroid
    map.split("\n").each_with_index do |row, y|
      row.split("").each_with_index do |col, x|
        asteroids.push(Asteroid.new(x,y)) if col == "#"
      end
    end
    new(asteroids)
  end

  def initialize(@asteroids)
  end

  def detected_asteroids_for(asteroid)
    other_asteroids = asteroids.reject { |a| a == asteroid }.sort_by { |a| distance_between(asteroid, a) }
    visible_asteroids = [] of Asteroid
    # Run through other_asteroids in order and remove any that are blocked.
    while other_asteroids.size > 0
      current_asteroid = other_asteroids.shift
      visible_asteroids.push(current_asteroid)
      other_asteroids.reject! { |asteroid3| blocks(asteroid, current_asteroid, asteroid3) }
    end
    return visible_asteroids
  end

  def most_asteroids_visible
    asteroids.map { |asteroid| {asteroid, detected_asteroids_for(asteroid).size} }.max_by { |result| result[1] }
  end

  private def distance_between(asteroid1, asteroid2)
    (asteroid1.x - asteroid2.x).abs + (asteroid1.y - asteroid2.y).abs
  end

  private def blocks(asteroid1, asteroid2, asteroid3)
    slope(asteroid1, asteroid2) == slope(asteroid1, asteroid3)
  end

  private def slope(asteroid1, asteroid2)
    Math.atan2(asteroid1.x - asteroid2.x, asteroid1.y - asteroid2.y)
  end
end