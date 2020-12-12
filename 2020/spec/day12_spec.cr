require "spec"
require "../days/day12.cr"

input = "F10
N3
F7
R90
F11"

describe Ship do
  it "travels with the directions" do
    ship = Ship.new
    ship.travel(input).should eq(25)
  end

  it "travels by moving a waypoint" do
    ship = Ship.new
    ship.waypoint_travel(input).should eq(286)
  end
end
