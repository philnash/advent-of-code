require "spec"
require "../days/day1.cr"

input = [1721, 979, 366, 299, 675, 1456]

describe "expenses" do
  it "finds items that sum to 2020" do
    pair = Expenses.new(input).sum_to_2020
    pair.should contain(1721)
    pair.should contain(299)
  end

  it "multiplies the pair that sum to 2020" do
    Expenses.new(input).multiple.should eq(514579)
  end

  it "finds 3 items that sum to 2020" do
    three = Expenses.new(input).sum_to_2020(3)
    three.should contain(979)
    three.should contain(366)
    three.should contain(675)
  end

  it "multiplies the three that sum to 2020" do
    Expenses.new(input).multiple(3).should eq(241861950)
  end
end
