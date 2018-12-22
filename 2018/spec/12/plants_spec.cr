require "spec"
require "../../12/plants.cr"

input = <<-STATE
initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #
STATE

describe Plants do
  it "parses the initial input" do
    plants = Plants.parse(input)
    if plants
      plants.state.should eq("#..#.#..##......###...###")
      plants.rules["...##"].should eq("#")
    else
      raise "Plants should be assigned"
    end
  end

  it "ticks over" do
    plants = Plants.parse(input)
    if plants
      plants.tick
      plants.state.should eq("#...#....#.....#..#..#..#")
    end
  end

  it "ticks multiple times" do
    plants = Plants.parse(input)
    if plants
      plants.tick(20)
      plants.state.should eq("#....##....#####...#######....#.#..##")
      plants.count.should eq(325)
    end
  end
end
