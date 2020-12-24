struct Point
  getter x : Int32
  getter y : Int32

  def initialize(@x, @y)
  end

  def ==(other : Point)
    @x == other.x && @y == other.y
  end
end

class HexTile
  enum Colour
    White
    Black
  end

  getter point : Point
  getter colour : Colour

  def initialize(@point : Point, @colour = Colour::White)
  end

  def tile_by_directions(directions : String, tiles : Hash(Point, HexTile))
    dist_east = point.x
    dist_north = point.y
    while directions.size > 0
      if directions.starts_with?("e")
        dist_east += 2
        directions = directions[1..-1]
      elsif directions.starts_with?("w")
        dist_east -= 2
        directions = directions[1..-1]
      elsif directions.starts_with?("ne")
        dist_east += 1
        dist_north += 1
        directions = directions[2..-1]
      elsif directions.starts_with?("nw")
        dist_east -= 1
        dist_north += 1
        directions = directions[2..-1]
      elsif directions.starts_with?("se")
        dist_east += 1
        dist_north -= 1
        directions = directions[2..-1]
      elsif directions.starts_with?("sw")
        dist_east -= 1
        dist_north -= 1
        directions = directions[2..-1]
      end
    end
    point = Point.new(dist_east, dist_north)
    if tile = tiles.has_key?(point)
      tiles[point]
    else
      HexTile.new(point)
    end
  end

  def neighbours(tiles)
    ["e", "w", "ne", "nw", "se", "sw"].map { |direction| tile_by_directions(direction, tiles) }
  end

  def flip_if_rule(tiles)
    black_neighbours = neighbours(tiles).map { |tile| tile.colour }.count { |c| c == Colour::Black }
    if @colour == Colour::White && black_neighbours == 2
      self.class.new(@point, Colour::Black)
    elsif @colour == Colour::Black && (black_neighbours == 0 || black_neighbours > 2)
      self.class.new(@point, Colour::White)
    else
      self.class.new(@point, @colour)
    end
  end

  def flip!
    if @colour == Colour::White
      @colour = Colour::Black
    else
      @colour = Colour::White
    end
  end

  def ==(other)
    @point == other.point
  end
end

input = "sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew"

input = File.read("days/day24.txt")

reference_tile = HexTile.new(Point.new(0, 0))
tiles = Hash(Point, HexTile).new
input.each_line { |line|
  tile = reference_tile.tile_by_directions(line, tiles)
  tiles[tile.point] = tile unless tiles.has_key?(tile.point)
  tile.flip!
}
puts "After directions, there are: #{tiles.values.count { |tile| tile.colour == HexTile::Colour::Black }} black tiles"

tiles = tiles.reject { |point, tile| tile.colour == HexTile::Colour::White }

# Need to consistently deal with a Hash(Point, Tile) not an array
100.times do
  tiles_and_neighbours = tiles.reduce(Set(HexTile).new) { |acc, (point, tile)|
    acc.add(tile)
    tile.neighbours(tiles).each { |t| acc.add(t) }
    acc
  }
  tiles = tiles_and_neighbours.map { |tile|
    tile.flip_if_rule(tiles)
  }.reject { |tile| tile.colour == HexTile::Colour::White }.reduce(Hash(Point, HexTile).new) { |acc, tile|
    acc[tile.point] = tile
    acc
  }
end

puts "Day 100: #{tiles.values.count { |tile| tile.colour == HexTile::Colour::Black }}"
