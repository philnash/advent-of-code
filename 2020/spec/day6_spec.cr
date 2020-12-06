require "spec"
require "../days/day6.cr"

input = "abc

a
b
c

ab
ac

a
a
a
a

b"

describe "Family groups" do
  it "should add up all the yeses" do
    FamilyGroup.new(["a", "b", "c"]).yeses.should eq(3)
    FamilyGroup.new(["abc"]).yeses.should eq(3)
  end
end
