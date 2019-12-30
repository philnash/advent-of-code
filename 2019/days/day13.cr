require "./intcode"

class Game
  getter tiles : Hash(String,Tile)
  getter score : Int64

  def initialize(program, play_for_free = false)
    if play_for_free
      program = "2" + program[1..-1]
    end
    @computer = Intcode::Computer.new(program)
    @tiles = Hash(String, Tile).new
    @score = 0_i64
  end

  def play
    run
    while !finished?
      ball = find_ball
      paddle = find_paddle
      if ball.x < paddle.x
        input = -1_i64
      elsif ball.x > paddle.x
        input = 1_i64
      else 
        input = 0_i64
      end
      run([input])
    end
    @score
  end

  def run(input = [] of Int64)
    @computer.run(input)
    output = @computer.output
    output.in_groups_of(3, 0) do |tile|
      if tile[0] == -1_i64 && tile[1] == 0
        @score = tile[2].to_i64
      else
        @tiles["#{tile[0]},#{tile[1]}"] = Tile.new(tile[0], tile[1], tile[2])
      end
    end
  end

  def finished?
    @computer.halted
  end

  def find_ball
    ball = @tiles.values.find { |t| t.type == TileType::Ball }
    raise "Ball lost!" if ball.nil?
    ball
  end

  def find_paddle
    paddle = @tiles.values.find { |t| t.type == TileType::Paddle }
    raise "paddle lost!" if paddle.nil?
    paddle
  end

  def render
    xs = @tiles.values.map { |t| t.x }
    ys = @tiles.values.map { |t| t.y }
    puts (ys.min..ys.max).map { |y|
      (xs.min..xs.max).map { |x|
        tile = @tiles["#{x},#{y}"]?
        square = tile.nil? ? " " : tile.render
      }.join("")
    }.join("\n")
  end

  enum TileType
    Empty
    Wall
    Block
    Paddle
    Ball
  end

  class Tile
    getter x : Int64
    getter y : Int64
    getter type : TileType

    def initialize(x, y, type)
      @x = x.to_i64
      @y = y.to_i64
      @type = TileType.new(type.to_i32)
    end

    def render
      case @type
      when TileType::Empty
        " "
      when TileType::Wall
        "#"
      when TileType::Block
        "~"
      when TileType::Paddle
        "_"
      else
        0
      end
    end
  end
end

input = File.read("./days/day13.txt")
game = Game.new(input, true)
puts game.play