require "spec"
require "../days/day10.cr"

input_a = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
input_b = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

describe JoltAdapters do
  it "calculates the correct differences" do
    JoltAdapters.new(input_a).difference_multiple.should eq(35)
    JoltAdapters.new(input_b).difference_multiple.should eq(220)
  end

  it "calculates the number of arrangements" do
    JoltAdapters.new(input_a).all_connections.should eq(8)
    JoltAdapters.new(input_b).all_connections.should eq(19208)
  end
end
