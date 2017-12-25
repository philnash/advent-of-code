class Program
  getter name : String
  property weight : Int32?
  property children : Array(Program)
  property parent : Program?

  def initialize(@name)
    @children = [] of Program
  end

  def has_parent?
    !parent.nil?
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

  def bottom_program
    tuple = @listing.find { |name, program| !program.has_parent? }
    return tuple[1] if tuple
  end
end
