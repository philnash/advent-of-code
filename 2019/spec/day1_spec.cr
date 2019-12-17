require "spec"
require "../days/day1.cr"

describe "fuel_required" do
  it "takes a mass, divides by three, rounds down, and subtracts 2" do
    fuel_required(12).should eq(2)
    fuel_required(14).should eq(2)
    fuel_required(1969).should eq(654)
    fuel_required(100756).should eq(33583)
  end
end

describe "total_module_fuel_required" do
  it "calculates the fuel mass until negative fuel is required" do
    total_module_fuel_required(14).should eq(2)
    total_module_fuel_required(1969).should eq(966)
    total_module_fuel_required(100756).should eq(50346)
  end
end