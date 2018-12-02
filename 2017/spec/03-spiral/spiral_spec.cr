require "spec"
require "../../03-spiral/spiral"

describe "Spiral" do
  describe "#distance" do
    it "should return 0 for 1" do
      Spiral.distance(1).should eq(0)
    end

    it "should return 2 for 3" do
      Spiral.distance(3).should eq(2)
    end

    it "should return 2 for 9" do
      Spiral.distance(9).should eq(2)
    end

    it "should return 3 for 12" do
      Spiral.distance(12).should eq(3)
    end

    it "should return 2 for 23" do
      Spiral.distance(23).should eq(2)
    end

    it "should return 31 for 1024" do
      Spiral.distance(1024).should eq(31)
    end
  end
end