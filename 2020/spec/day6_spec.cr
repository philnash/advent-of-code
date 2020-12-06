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
    FamilyGroup.new([["a", "b", "c"]]).any_yeses.should eq(3)
    FamilyGroup.new([["a"], ["b"], ["c"]]).any_yeses.should eq(3)
    FamilyGroup.new([["a", "b"], ["a", "c"]]).any_yeses.should eq(3)
    FamilyGroup.new([["a"], ["a"], ["a"], ["a"]]).any_yeses.should eq(1)
    FamilyGroup.new([["b"]]).any_yeses.should eq(1)
  end

  it "should add up all the groups yeses" do
    FamilyGroup.any_yes(input).should eq(11)
  end

  it "should add up yeses for every answer" do
    FamilyGroup.new([["a", "b", "c"]]).all_yeses.should eq(3)
    FamilyGroup.new([["a"], ["b"], ["c"]]).all_yeses.should eq(0)
    FamilyGroup.new([["a", "b"], ["a", "c"]]).all_yeses.should eq(1)
    FamilyGroup.new([["a"], ["a"], ["a"], ["a"]]).all_yeses.should eq(1)
    FamilyGroup.new([["b"]]).all_yeses.should eq(1)
  end

  it "should add up all the groups combined yeses" do
    FamilyGroup.every_yes(input).should eq(6)
  end
end
