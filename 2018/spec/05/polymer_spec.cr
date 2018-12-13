require "spec"
require "../../05/polymer.cr"

describe Polymer do
  it "returns an empty string if all units react" do
    Polymer.react("aA").should eq("")
    Polymer.react("abBA").should eq("")
  end

  it "returns the original string if no units react" do
    Polymer.react("abAB").should eq("abAB")
    Polymer.react("aabAAB").should eq("aabAAB")
  end

  it "reduces the polymer to the shortest length" do
    Polymer.react("dabAcCaCBAcCcaDA").should eq("dabCBAcaDA")
  end

  it "finds the best when you remove one unit" do
    Polymer.find_best("dabAcCaCBAcCcaDA").size.should eq(4)
  end
end