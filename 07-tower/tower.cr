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
    @listing.find { |name, program| !program.has_parent? }
  end
end

input = "pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"
listing = ProgramListing.new
listing.parse(input)
program = listing.bottom_program
puts program[0] if program
