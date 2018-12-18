require "spec"
require "../../18/lumber.cr"

input = <<-LANDSCAPE
.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.
LANDSCAPE

describe Landscape do
  it "parses the input" do
    landscape = Landscape.parse(input)
    landscape[0,0].fill.should eq(Acre::Fill::Open)
    landscape[1,0].fill.should eq(Acre::Fill::Lumberyard)
    landscape[8,9].fill.should eq(Acre::Fill::Trees)
  end

  it "moves one tick" do
    landscape = Landscape.parse(input)
    landscape = landscape.tick
    expected = <<-LANDSCAPE
    .......##.
    ......|###
    .|..|...#.
    ..|#||...#
    ..##||.|#|
    ...#||||..
    ||...|||..
    |||||.||.|
    ||||||||||
    ....||..|.
    LANDSCAPE
    landscape.draw.should eq(expected)
  end

  it "moves 10 ticks" do
    landscape = Landscape.parse(input)
    landscape = landscape.tick(10)
    expected = <<-LANDSCAPE
    .||##.....
    ||###.....
    ||##......
    |##.....##
    |##.....##
    |##....##|
    ||##.####|
    ||#####|||
    ||||#|||||
    ||||||||||
    LANDSCAPE
    landscape.draw.should eq(expected)
    landscape.total.should eq(1147)
  end
end