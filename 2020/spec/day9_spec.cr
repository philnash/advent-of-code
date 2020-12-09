require "spec"
require "../days/day9.cr"

input = "35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576".split("\n").map(&.to_i64)

describe Xmas do
  it "finds the invalid number" do
    xmas = Xmas.new(input, 5)
    xmas.find_invalid_input.should eq(127)
  end

  it "finds the encryption weakness" do
    xmas = Xmas.new(input, 5)
    xmas.find_encryption_weakness.should eq(62)
  end
end
