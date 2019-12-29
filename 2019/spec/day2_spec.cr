require "spec"
require "../days/day2"

describe Intcode2 do
  it "turns 1,0,0,0,99 into 2,0,0,0,99" do
    computer = Intcode2.new("1,0,0,0,99")
    computer.run.to_s.should eq("2,0,0,0,99")
  end

  it "turns 2,3,0,3,99 into 2,3,0,6,99" do
    computer = Intcode2.new("2,3,0,3,99")
    computer.run.to_s.should eq("2,3,0,6,99")
  end

  it "turns 2,4,4,5,99,0 into 2,4,4,5,99,9801" do
    computer = Intcode2.new("2,4,4,5,99,0")
    computer.run.to_s.should eq("2,4,4,5,99,9801")
  end

  it "turns 1,1,1,4,99,5,6,0,99 into 30,1,1,4,2,5,6,0,99" do
    computer = Intcode2.new("1,1,1,4,99,5,6,0,99")
    computer.run.to_s.should eq("30,1,1,4,2,5,6,0,99")
  end

  it "turns 1,9,10,3,2,3,11,0,99,30,40,50 into 3500,9,10,70,2,3,11,0,99,30,40,50" do
    computer = Intcode2.new("1,9,10,3,2,3,11,0,99,30,40,50")
    computer.run.to_s.should eq("3500,9,10,70,2,3,11,0,99,30,40,50")
  end
end