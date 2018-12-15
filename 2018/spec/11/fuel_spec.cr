require "spec"
require "../../11/fuel.cr"

describe PowerGrid do
  it "can calculate power_level from x, y" do
    p1 = PowerGrid.new(8)
    p1.power_level(3, 5).should eq(4)
    p2 = PowerGrid.new(57)
    p2.power_level(122, 79).should eq(-5)
    p3 = PowerGrid.new(39)
    p3.power_level(217, 196).should eq(0)
    p4 = PowerGrid.new(71)
    p4.power_level(101,153).should eq(4)
  end

  it "can calculate the max subgrid" do
    p1 = PowerGrid.new(18)
    p1.get_highest_subgrid(3).should eq({"33,45", 29})
    p2 = PowerGrid.new(42)
    p2.get_highest_subgrid(3).should eq({"21,61", 30})
  end
end