require "spec"
require "../../06/coordinates.cr"

describe Coordinate do
  it "initializes with an x and y" do
    coordinate = Coordinate.new(1,2)
    coordinate.x.should eq(1)
    coordinate.y.should eq(2)
  end

  it "calculates the manhattan distance between the coordinate and another point" do
    coordinate = Coordinate.new(1,2)
    coordinate.manhattan_distance(1,3).should eq(1)
    coordinate.manhattan_distance(2,2).should eq(1)
    coordinate.manhattan_distance(4,4).should eq(5)
    coordinate.manhattan_distance(Coordinate.new(4,4)).should eq(5)
  end
end

describe Grid do
  it "initializes with an array of coordinates" do
    grid = Grid.new([Coordinate.new(1,2), Coordinate.new(3, 4)])
    grid.origin_x.should eq(0)
    grid.origin_y.should eq(1)
    grid.width.should eq(4)
    grid.height.should eq(4)
  end

#   0 1 2 3
# 0 . . . .
# 1 . . 1 .
# 2 . . . .
# 3 . . . .
# 4 . . . 2

  it "returns the coord or closest coord" do
    coord1 = Coordinate.new(1,2)
    coord2 = Coordinate.new(3, 4)
    grid = Grid.new([coord1, coord2])
    grid[0, 1].should eq(coord1)
    grid[1, 2].should eq(coord1)
    grid[3, 3].should eq(coord2)
    grid[2, 3].should be_nil
  end

  it "returns the greatest finite area" do
    c1 = Coordinate.new(1, 1)
    c2 = Coordinate.new(1, 6)
    c3 = Coordinate.new(8, 3)
    c4 = Coordinate.new(3, 4)
    c5 = Coordinate.new(5, 5)
    c6 = Coordinate.new(8, 9)
    grid = Grid.new([c1,c2,c3,c4,c5,c6])
    grid.greatest_finite_area.should eq(17)
  end

  it "returns the region within distance" do
    c1 = Coordinate.new(1, 1)
    c2 = Coordinate.new(1, 6)
    c3 = Coordinate.new(8, 3)
    c4 = Coordinate.new(3, 4)
    c5 = Coordinate.new(5, 5)
    c6 = Coordinate.new(8, 9)
    grid = Grid.new([c1,c2,c3,c4,c5,c6])
    grid.region_within(32).should eq(16)
  end
end