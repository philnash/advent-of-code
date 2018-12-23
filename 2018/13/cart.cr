struct TrackPiece
  getter x : Int32
  getter y : Int32
  getter piece : String

  def initialize(@x, @y, @piece)
  end
end

class Crash < Exception
  getter x : Int32
  getter y : Int32

  def initialize(@x, @y, message : String? = nil, cause : Exception? = nil)
    super(message, cause)
  end
end

class Track
  PIECES = ["|", "-", "\\", "/", "+"]

  getter pieces : Array(TrackPiece)
  getter carts : Array(Cart)

  def self.parse(text)
    pieces = [] of TrackPiece
    carts = [] of Cart
    text.split("\n").each_with_index do |line, row|
      line.split("").each_with_index do |char, col|
        if PIECES.includes?(char)
          pieces.push(TrackPiece.new(col, row, char))
        end
        if Cart::DIRECTION_MAP.keys.includes?(char)
          cart = Cart.new(col, row, char)
          carts.push(cart)
          direction = char == ">" || char == "<" ? "-" : "|"
          pieces.push(TrackPiece.new(col, row, direction))
        end
      end
    end
    new(pieces, carts)
  end

  def initialize(@pieces, @carts)
  end

  def [](x, y)
    @carts.find { |cart| cart.x == x && cart.y == y } || piece(x, y) || TrackPiece.new(x, y, " ")
  end

  def piece(x, y) : TrackPiece | Nil
    @pieces.find { |piece| piece.x == x && piece.y == y }
  end

  def tick
    while carts.size > 1
      @carts.sort_by { |c| [c.x, c.y] }.each do |cart|
        begin
          cart.move(self)
        rescue crash : Crash
          puts "#{crash.x},#{crash.y}"
          # break "#{crash.x},#{crash.y}"
        end
      end
    end
  end

  def draw
    max_x = pieces.map(&.x).max
    max_y = pieces.map(&.y).max
    rows = (0..max_y).to_a.map do |row|
      (0..max_x).to_a.map { |col| self[col, row].piece }.join("")
    end
    rows.join("\n")
  end

  def remove_carts(to_delete : Array(Cart))
    to_delete.each { |cart| @carts.delete(cart) }
  end
end

class Cart
  enum Direction
    Up
    Down
    Left
    Right
  end

  DIRECTION_MAP = {
    "^" => Direction::Up,
    "v" => Direction::Down,
    ">" => Direction::Right,
    "<" => Direction::Left,
  }
  PRINT_MAP = {
    Direction::Up    => "^",
    Direction::Down  => "v",
    Direction::Right => ">",
    Direction::Left  => "<",
  }

  CHOICES = ["left", "straight", "right"]

  getter x : Int32
  getter y : Int32
  @direction : Direction
  @choice : Int32

  def initialize(@x, @y, char : String)
    @direction = DIRECTION_MAP.fetch(char, Direction::Up)
    @choice = 0
  end

  def piece
    PRINT_MAP.fetch(@direction, "v")
  end

  def move(track)
    next_pos(track).try do |piece|
      if piece.is_a?(Cart)
        track.remove_carts([self, piece])
        raise Crash.new(piece.x, piece.y)
      end
      @x = piece.x
      @y = piece.y
      @direction = case {piece.piece, @direction}
                   when {"\\", Direction::Right}, {"/", Direction::Left}
                     Direction::Down
                   when {"\\", Direction::Up}, {"/", Direction::Down}
                     Direction::Left
                   when {"\\", Direction::Down}, {"/", Direction::Up}
                     Direction::Right
                   when {"\\", Direction::Left}, {"/", Direction::Right}
                     Direction::Up
                   when {"+", Direction::Right}, {"+", Direction::Up}, {"+", Direction::Down}, {"+", Direction::Left}
                     choose(@direction)
                   else
                     @direction
                   end
    end
  end

  def choose(current_direction)
    new_direction = case {current_direction, CHOICES[@choice]}
                    when {Direction::Up, "left"}
                      Direction::Left
                    when {Direction::Right, "left"}
                      Direction::Up
                    when {Direction::Down, "left"}
                      Direction::Right
                    when {Direction::Left, "left"}
                      Direction::Down
                    when {Direction::Up, "right"}
                      Direction::Right
                    when {Direction::Right, "right"}
                      Direction::Down
                    when {Direction::Down, "right"}
                      Direction::Left
                    when {Direction::Left, "right"}
                      Direction::Up
                    else
                      current_direction
                    end
    @choice = (@choice + 1) % 3
    new_direction
  end

  def next_pos(track)
    case @direction
    when .up?
      track[x, y - 1]
    when .down?
      track[x, y + 1]
    when .left?
      track[x - 1, y]
    else
      track[x + 1, y]
    end
  end
end

input = <<-MAP
/----\\
|    v
|    |
\\----/
MAP

input2 = <<-MAP
/-----\\
|     |
|  /--+--\\
|  |  |  |
\\--+<-/  |
   |     |
   \\-----/
MAP

input3 = <<-MAP
/->-\\
|   |  /----\\
| /-+--+-\\  |
| | |  | v  |
\\-+-/  \\-+--/
  \\------/
MAP

input4 = <<-MAP
/>-<\\
|   |
| /<+-\\
| | | v
\\>+</ |
  |   ^
  \\<->/
MAP

track = Track.parse(input4)
puts track.tick
puts track.draw
# cart = track.carts.first
# puts track.draw
# cart.move(track)
# cart.move(track)
# cart.move(track)
# 14.times { cart.move(track) }
# puts track.draw
# 4.times { cart.move(track) }
# puts track.draw
# track2 = Track.parse(input2)
# puts track2.draw
