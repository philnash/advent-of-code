class CaveSystem
  @caves : Array(Cave)

  def initialize(input : Array(String))
    @caves = Array(Cave).new
    input.each do |line|
      caves = line.split("-").map do |c|
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

  def traverse
    paths = Array(CavePath).new
    complete_paths = Array(CavePath).new
    start = @caves.find { |cave| cave.name == "start" }
    if start
      paths.push(CavePath.new(start))
      while paths.size > 0
        current_path = paths.shift
        current_cave = current_path.last
        connections = current_cave.connected_caves
        connections.each do |new_cave|
          new_path = CavePath.new(current_path)
          if new_path.visit(new_cave)
            if new_path.complete?
              complete_paths.push(new_path)
            else
              paths.push(new_path)
            end
          end
        end
      end
    end
    complete_paths
  end

  def extended_traverse
    paths = Array(ExtendedCavePath).new
    complete_paths = Array(ExtendedCavePath).new
    start = @caves.find { |cave| cave.name == "start" }
    if start
      paths.push(ExtendedCavePath.new(start))
      while paths.size > 0
        current_path = paths.shift
        current_cave = current_path.last
        connections = current_cave.connected_caves
        connections.each do |new_cave|
          new_path = ExtendedCavePath.new(current_path)
          if new_path.visit(new_cave)
            if new_path.complete?
              complete_paths.push(new_path)
            else
              paths.push(new_path)
            end
          end
        end
      end
    end
    complete_paths
  end
end

class CavePath
  getter path : Array(Cave)
  getter visited_small_caves : Set(Cave)

  def initialize(cave : Cave)
    @path = [] of Cave
    @path.push(cave)
    @visited_small_caves = Set(Cave).new
    @visited_small_caves.add(cave) if cave.small?
  end

  def initialize(cave_path)
    @path = cave_path.path.dup
    @visited_small_caves = cave_path.visited_small_caves.dup
  end

  def visit(cave : Cave)
    if @visited_small_caves.includes?(cave)
      false
    else
      path.push(cave)
      @visited_small_caves.add(cave) if cave.small?
      true
    end
  end

  def last
    @path.last
  end

  def complete?
    @path.last.name == "end"
  end

  def to_s
    @path.map(&.name).join("-")
  end
end

class ExtendedCavePath < CavePath
  getter small_cave_visited_twice : Bool

  def initialize(cave : Cave)
    super(cave)
    @small_cave_visited_twice = false
  end

  def initialize(cave_path)
    super(cave_path)
    @small_cave_visited_twice = cave_path.small_cave_visited_twice
  end

  def visit(cave : Cave)
    if @visited_small_caves.includes?(cave) && small_cave_visited_twice || cave.name == "start"
      false
    else
      path.push(cave)
      if cave.small?
        if @visited_small_caves.includes?(cave) && !@small_cave_visited_twice
          @small_cave_visited_twice = true
        end
        @visited_small_caves.add(cave)
      end
      true
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

  getter connected_caves : Array(Cave)
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

input = "fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW".split("\n")

caves = CaveSystem.new(input)
paths = caves.traverse
puts paths.map(&.to_s).join("\n")
puts paths.size

paths = caves.extended_traverse
puts paths.map(&.to_s).join("\n")
puts paths.size
