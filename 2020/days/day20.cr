class Map
  getter tiles : Array(Tile)
  getter width : Int32

  def initialize(input : String)
    @tiles = input.split("\n\n").map { |str| Tile.new(str) }
    @width = Math.sqrt(@tiles.size).to_i
  end

  def tiles_and_borders
    @tiles.map { |tile|
      rest = @tiles.reject { |t| t == tile }
      {tile, rest.select { |other|
        tile.shares_borders_with?(other)
      }.count { |a| a }}
    }
  end

  def corners
    tiles_and_borders.select { |(t, count)| count == 2 }.map { |(t, count)| t }
  end

  def corner_product
    corners.map { |t| t.id }.product
  end

  def place_in_grid
    unused_tiles = @tiles.dup
    corner_tiles = corners
    last_tile = corner_tiles.first
    remaining = unused_tiles.delete(last_tile)
    next_tile = last_tile.arrangements.find { |tile|
      other_tiles = unused_tiles.flat_map { |t| t.arrangements }
      below = other_tiles.find { |other| tile.bottom_border == other.top_border }
      right = other_tiles.find { |other| tile.right_border == other.left_border }
      below && right
    }
    if next_tile
      grid = [[next_tile]]
      last_tile = next_tile
      i = 1
      while i < @width
        next_tile = unused_tiles.flat_map { |t| t.arrangements }.find { |tile| tile.top_border == last_tile.bottom_border }
        if next_tile
          grid.push([next_tile])
          last_tile = next_tile
          unused_tiles = unused_tiles.reject { |t| t.id == last_tile.id }
          i += 1
        else
          raise "ARRGH"
        end
      end
      grid.each do |row|
        i = 1
        last_tile = row[0]
        while i < @width
          next_tile = unused_tiles.flat_map { |t| t.arrangements }.find { |tile| tile.left_border == last_tile.right_border }
          if next_tile
            row.push(next_tile)
            last_tile = next_tile
            unused_tiles = unused_tiles.reject { |t| t.id == last_tile.id }
            i += 1
          else
            raise "ARRGH"
          end
        end
      end
      return grid
    else
      raise "Can't find a corner tile that works"
    end
  end

  def print(grid : Array(Array(Tile)), strip = false)
    # puts grid.map { |r| r.map { |col| col.id }.join(" ") }.join("\n")
    grid.map { |row|
      row_string = ""
      i = (strip ? 1 : 0)
      while i < row.first.width - (strip ? 1 : 0)
        j = 0
        while j < row.size
          row_string += row[j].print(i, strip)
          j += 1
        end
        i += 1
        row_string += "\n" unless i == row.first.width - (strip ? 1 : 0)
      end
      row_string
    }.join("\n")
  end
end

class Tile
  getter id : Int64
  getter data : Array(Array(String))

  def initialize(input : String)
    lines = input.split("\n")
    match_data = lines.first.match(/(\d+)/)
    if match_data
      @id = match_data[1].to_i64
    else
      raise "This ain't right"
    end
    @data = lines[1..].map { |line| line.split("") }
  end

  def initialize(@id, @data)
  end

  def width
    @data.first.size
  end

  def borders
    [
      @data.first.join(""),
      @data.last.join(""),
      @data.map { |line| line.first }.join(""),
      @data.map { |line| line.last }.join(""),
      @data.first.reverse.join(""),
      @data.last.reverse.join(""),
      @data.map { |line| line.first }.reverse.join(""),
      @data.map { |line| line.last }.reverse.join(""),
    ]
  end

  def shares_borders_with?(tile)
    (borders & tile.borders).size > 0
  end

  def print
    @data.map { |line| line.join("") }.join("\n")
  end

  def print(row : Int32, strip = false)
    if strip
      @data[row][1...-1].join("")
    else
      @data[row].join("")
    end
  end

  def rotate_cw
    Tile.new(@id, @data.reverse.transpose)
  end

  def flip_vertical
    Tile.new(@id, @data.reverse)
  end

  def arrangements
    rot90 = rotate_cw
    rot180 = rot90.rotate_cw
    rot270 = rot180.rotate_cw
    flip = flip_vertical
    flip_rot90 = flip.rotate_cw
    flip_rot180 = flip_rot90.rotate_cw
    flip_rot270 = flip_rot180.rotate_cw
    [
      self, rot90, rot180, rot270, flip, flip_rot90, flip_rot180, flip_rot270,
    ]
  end

  def bottom_border
    @data.last.join("")
  end

  def top_border
    @data.first.join("")
  end

  def right_border
    @data.map { |line| line.last }.join("")
  end

  def left_border
    @data.map { |line| line.first }.join("")
  end
end

input = "Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###..."

input = File.read("./days/day20.txt")

map = Map.new(input)

# pp map.tiles_and_borders.map { |(tile, count)| {tile.id, count} }
# corners = map.corners
# remaining = tiles - corners
# pp corners.map { |tile| "#{tile.id} => #{remaining.select { |other| tile.shares_borders_with?(other) }.map { |t| t.id }}" }
# puts map.width

tile = map.tiles.first

# puts tile.print + "\n\n"
# tile.rotate_cw
# puts tile.print + "\n\n"
# tile.flip
# puts tile.print

map.print(map.place_in_grid, false)
# puts "\n---\n"
grid = map.place_in_grid
# puts "\n---\n"
new_map = map.print(grid, true)
# puts new_map
# puts "\n---\n"
new_map = new_map.split("\n").map { |line| line.split("") }

def print(map)
  puts map.map { |row| row.map { |col| col }.join("") }.join("\n")
end

puts("New map")
print(new_map)

other_map = new_map.reverse.transpose
count = 0
while (new_map != other_map)
  puts count
  count += 1
  other_map = other_map.reverse.transpose
end

monst1 = "..................#."
monst2 = "#....##....##....###"
monst3 = ".#..#..#..#..#..#..."

monster_pieces = (monst1 + monst2 + monst3).split("").select { |str| str == "#" }.size
puts "Monster pieces:  #{monster_pieces}"
rough_waters = new_map.map { |row| row.count { |i| i == "#" } }.sum
puts "Total #: #{rough_waters}"

monsters = [
  new_map,
  new_map.reverse.transpose,
  new_map.reverse.transpose.reverse.transpose,
  new_map.reverse.transpose.reverse.transpose.reverse.transpose,
  new_map.reverse,
  new_map.reverse.reverse.transpose,
  new_map.reverse.reverse.transpose.reverse.transpose,
  new_map.reverse.reverse.transpose.reverse.transpose.reverse.transpose,
].map { |map_to_test|
  matches = 0
  map_to_test.each_with_index { |row, index|
    width = row.size - monst1.size
    x = 0
    while x < width + 1
      y = width - x
      # puts [x, y]
      test_monst1 = "."*x + monst1 + "."*y
      test_monst2 = "."*x + monst2 + "."*y
      test_monst3 = "."*x + monst3 + "."*y
      # puts [test_monst1, test_monst2, test_monst3].join("\n")
      begin
        # puts "1: #{row.join("").match(Regex.new(test_monst1))}"
        # puts "2: #{map_to_test[index + 1].join("").match(Regex.new(test_monst2))}"
        # puts "3: #{map_to_test[index + 2].join("").match(Regex.new(test_monst3))}"
        if row.join("").match(Regex.new(test_monst1)) &&
           map_to_test[index + 1].join("").match(Regex.new(test_monst2)) &&
           map_to_test[index + 2].join("").match(Regex.new(test_monst3))
          matches += 1
        end
      rescue
      end
      x += 1
    end
  }
  matches
}.max

puts rough_waters - (monster_pieces * monsters)
