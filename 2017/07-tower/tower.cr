class Program
  getter name : String
  setter weight : Int32?
  property children : Array(Program)
  property parent : Program?

  def initialize(@name)
    @children = [] of Program
  end

  def has_parent?
    !parent.nil?
  end

  def weight
    @weight || 0
  end

  def total_weight
    if children.empty?
      total_weight = weight
    else
      child_weights = children.map { |c| c.total_weight.as(Int32) }
      total_weight = weight + child_weights.sum
    end
    total_weight
  end
end

class ProgramListing
  getter listing

  def initialize
    @listing = Hash(String, Program).new
  end

  def parse(list)
    list.split("\n").each do |line|
      parse_line(line)
    end
  end

  def parse_line(line)
    matches = /\A(?<name>[a-z]+)\s\((?<weight>\d+)\)(?: -> (?<children>[a-z]+(?:, (?:[a-z]+))*))?\z/.match(line)
    if matches
      program = find_or_create(matches["name"])
      program.weight = matches["weight"].to_i
      if matches["children"]?
        children_names = matches["children"].split(", ")
        children_names.each do |name|
          child = find_or_create(name)
          child.parent = program
          program.children << child
        end
      end
    end
  end

  def find_or_create(name)
    program = @listing.fetch(name, nil)
    return program if program
    program = Program.new(name)
    @listing[name] = program
    program
  end

  def bottom_program : Program?
    tuple = @listing.find { |name, program| !program.has_parent? }
    return tuple[1] if tuple
  end

  def balance(program : Program) : Int32
    child_weights = program.children.map { |c| {c, c.total_weight} }
    groups = child_weights.group_by { |c| c[1] }
    if groups.keys.size == 1
      return 0
    else
      return groups.map do |k, v|
        if v.size > 1
          0
        else
          b = balance(v.first[0])
          b == 0 ? v.first[0].weight - (groups.keys[0] - groups.keys[1]).abs : b
        end
      end.sum
    end
  end
end
