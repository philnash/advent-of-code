require "./intcode"

class Panel
  enum Colour
    Black
    White
  end

  property colour : Colour
  property x : Int32
  property y : Int32

  def initialize(@x, @y, @colour)
  end
end

class EmergencyHullPaintingRobot
  enum Direction
    Up
    Right
    Down
    Left
  end

  getter panels : Array(Panel)

  @computer : Intcode::Computer
  @x : Int32
  @y : Int32
  @current_direction : Direction

  def initialize(program, @panels = [] of Panel)
    @computer = Intcode::Computer.new(program)
    @x = 0
    @y = 0
    @current_direction = Direction::Up
  end

  def run
    while !@computer.halted
      paint
    end
    self
  end

  def paint
    current_panel = find_panel(@x, @y)
    input = current_panel.colour.value
    output = @computer.run([input]).output
    paint_colour = output[-2]
    direction_change = output[-1]
    current_panel.colour = Panel::Colour.new(paint_colour.to_i)
    if direction_change == 0
      @current_direction = turn_left(@current_direction)
    else
      @current_direction = turn_right(@current_direction)
    end
    @x, @y = move(@x, @y, @current_direction)
  end

  def render
    xs = @panels.map { |p| p.x }
    ys = @panels.map { |p| p.y }
    min_x = xs.min
    max_x = xs.max
    min_y = ys.min
    max_y = ys.max
    x = min_x
    y = min_y
    puts (min_y..max_y).map { |y|
      (min_x..max_x).map { |x|
        panel = find_panel(x, y)
        panel.colour == Panel::Colour::White ? "X" : " " 
      }.join("")
    }.join("\n")
  end

  private def find_panel(x, y)
    panel = @panels.find { |p| p.x == x && p.y == y }
    if panel.nil?
      panel = Panel.new(x, y, Panel::Colour::Black)
      @panels.push(panel)
    end
    panel
  end

  private def turn_left(direction)
    case direction
    when Direction::Up
      Direction::Left
    when Direction::Left
      Direction::Down
    when Direction::Down
      Direction::Right
    else
      Direction::Up
    end
  end

  private def turn_right(direction)
    case direction
    when Direction::Up
      Direction::Right
    when Direction::Right
      Direction::Down
    when Direction::Down
      Direction::Left
    else
      Direction::Up
    end
  end

  private def move(x, y, direction)
    case direction
    when Direction::Up
      {x, y - 1}
    when Direction::Right
      {x+1, y}
    when Direction::Down
      {x, y + 1}
    else
      {x - 1, y}
    end
  end
end