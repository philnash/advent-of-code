class CaveSystem
  @caves : Array(Cave)

  def initialize(input : Array(String))
    @caves = Array(Cave).new
    input.each do |line|
      caves = line.split("-").map do |c|
        puts @caves.map { |c| c.name }
        old_cave = @caves.find { |cave| cave.name == c }
        if old_cave
          old_cave
        else
          cave = Cave.new(c)
          @caves.push(cave)
          cave
        end
      end
      caves[0].add_connection(caves[1])
      caves[1].add_connection(caves[0])
    end
  end
end

class Cave
  enum Size
    Large
    Small

    def small?
      self == Small
    end
  end

  @connected_caves : Array(Cave)
  getter name : String
  @size : Size

  def initialize(@name)
    @connected_caves = Array(Cave).new
    @size = @name.downcase == @name ? Size::Small : Size::Large
  end

  def small?
    @size.small?
  end

  def add_connection(cave : Cave)
    @connected_caves.push(cave)
  end
end

input = "start-A
start-b
A-c
A-b
b-d
A-end
b-end".split("\n")

CaveSystem.new(input)
