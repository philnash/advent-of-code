class CodePage
  struct Point
    property x : Int32
    property y : Int32

    def initialize(@x, @y)
    end
  end

  struct Instruction
    getter axis : String
    getter value : Int32

    def initialize(@axis, @value)
    end
  end

  getter dots : Set(Point)
  @instructions : Array(Instruction)
  @width : Int32
  @height : Int32

  def initialize(input : String)
    @dots = Set(Point).new
    @instructions = Array(Instruction).new
    inputs = input.split("\n\n")

    inputs[0].split("\n").each do |line|
      points = line.split(",").map(&.to_i)
      @dots.add(Point.new(points[0], points[1]))
    end
    @width = @dots.map { |d| d.x }.max + 1
    @height = @dots.map { |d| d.y }.max + 1
    inputs[1].split("\n").each do |line|
      match_data = line.match(/^fold along ([xy])=(\d+)$/)
      if match_data
        @instructions.push(Instruction.new(match_data[1], match_data[2].to_i))
      end
    end
  end

  def [](x, y)
    dot = @dots.find { |d| d.x == x && d.y == y }
    return dot ? "#" : " "
  end

  def to_s
    map = ""
    @height.times do |row|
      row_s = ""
      @width.times do |col|
        row_s += self[col, row]
      end
      map += row_s + "\n"
    end
    map
  end

  def fold
    instruction = @instructions.shift
    if instruction.axis == "y"
      fold_up(instruction.value)
    else
      fold_left(instruction.value)
    end
  end

  def finish_folding
    while @instructions.size > 0
      self.fold
    end
  end

  def fold_up(value : Int32)
    folding_dots = @dots.select { |d| d.y > value }
    folding_dots.map do |dot|
      @dots.delete(dot)
      diff = dot.y - value
      dot.y = value - diff
      @dots.add(dot)
    end
    @height = value
  end

  def fold_left(value : Int32)
    folding_dots = @dots.select { |d| d.x > value }
    folding_dots.each do |dot|
      @dots.delete(dot)
      diff = dot.x - value
      dot.x = value - diff
      @dots.add(dot)
    end
    @width = value
  end
end
