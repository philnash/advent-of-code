require "spec"
require "../days/day9"

describe Intcode9 do
  it "turns 1,0,0,0,99 into 2,0,0,0,99" do
    computer = Intcode9::Computer.new("1,0,0,0,99")
    computer.run.to_s.should eq("2,0,0,0,99")
  end

  it "turns 2,3,0,3,99 into 2,3,0,6,99" do
    computer = Intcode9::Computer.new("2,3,0,3,99")
    computer.run.to_s.should eq("2,3,0,6,99")
  end

  it "turns 2,4,4,5,99,0 into 2,4,4,5,99,9801" do
    computer = Intcode9::Computer.new("2,4,4,5,99,0")
    computer.run.to_s.should eq("2,4,4,5,99,9801")
  end

  it "turns 1,1,1,4,99,5,6,0,99 into 30,1,1,4,2,5,6,0,99" do
    computer = Intcode9::Computer.new("1,1,1,4,99,5,6,0,99")
    computer.run.to_s.should eq("30,1,1,4,2,5,6,0,99")
  end

  it "turns 1,9,10,3,2,3,11,0,99,30,40,50 into 3500,9,10,70,2,3,11,0,99,30,40,50" do
    computer = Intcode9::Computer.new("1,9,10,3,2,3,11,0,99,30,40,50")
    computer.run.to_s.should eq("3500,9,10,70,2,3,11,0,99,30,40,50")
  end

  it "takes an input and places it in memory" do
    computer = Intcode9::Computer.new("3,3,99,0")
    computer.run([25]).to_s.should eq("3,3,99,25")
  end

  it "outputs to an array" do
    computer = Intcode9::Computer.new("4, 3, 99, 2")
    computer.run.output.should eq([2])
  end

  it "outputs 1 if the input is 8" do
    computer = Intcode9::Computer.new("3,9,8,9,10,9,4,9,99,-1,8")
    computer.run([8]).output.should eq([1])
  end

  describe "with the program 3,9,8,9,10,9,4,9,99,-1,8" do
    it "outputs 0 if the input is not 8" do
      computer = Intcode9::Computer.new("3,9,8,9,10,9,4,9,99,-1,8")
      computer.run([7]).output.should eq([0])
    end

    it "outputs 1 if the input is 8" do
      computer = Intcode9::Computer.new("3,3,1108,-1,8,3,4,3,99")
      computer.run([8]).output.should eq([1])
    end
  end

  describe "with the program 3,9,7,9,10,9,4,9,99,-1,8" do
    it "outputs 1 if the input is less than 8" do
      computer = Intcode9::Computer.new("3,9,7,9,10,9,4,9,99,-1,8")
      computer.run([7]).output.should eq([1])
    end

    it "outputs 0 if the input is not less than 8" do
      computer = Intcode9::Computer.new("3,9,7,9,10,9,4,9,99,-1,8")
      computer.run([8]).output.should eq([0])
    end
  end

  describe "with the program 3,3,1108,-1,8,3,4,3,99" do
    it "outputs 1 if the program is equal to 8" do
      computer = Intcode9::Computer.new("3,3,1108,-1,8,3,4,3,99")
      computer.run([8]).output.should eq([1])
    end

    it "outputs 0 if the program is not equal to 8" do
      computer = Intcode9::Computer.new("3,3,1108,-1,8,3,4,3,99")
      computer.run([9]).output.should eq([0])
    end
  end

  describe "with the program 3,3,1107,-1,8,3,4,3,99" do
    it "outputs 1 if the input is less than 8" do
      computer = Intcode9::Computer.new("3,3,1107,-1,8,3,4,3,99")
      computer.run([7]).output.should eq([1])
    end

    it "outputs 0 if the input is not less than 8" do
      computer = Intcode9::Computer.new("3,3,1107,-1,8,3,4,3,99")
      computer.run([8]).output.should eq([0])
    end
  end

  describe "with the program 3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9" do
    it "outputs 0 if the input is 0" do
      computer = Intcode9::Computer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
      computer.run([0]).output.should eq([0])
    end

    it "outputs 1 if the input is not 0" do
      computer = Intcode9::Computer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
      computer.run([10]).output.should eq([1])
    end
  end

  describe "with the program 3,3,1105,-1,9,1101,0,0,12,4,12,99,1" do
    it "outputs 0 if the input is 0" do
      computer = Intcode9::Computer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
      computer.run([0]).output.should eq([0])
    end

    it "outputs 1 if the input is not 0" do
      computer = Intcode9::Computer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
      computer.run([10]).output.should eq([1])
    end
  end

  describe "with the program 3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99" do
    it "outputs 999 if the input is less than 8" do
      computer = Intcode9::Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
      computer.run([5]).output.should eq([999])
    end

    it "outputs 1000 if the input is 8" do
      computer = Intcode9::Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
      computer.run([8]).output.should eq([1000])
    end

    it "outputs 1001 if the input is greater than 8" do
      computer = Intcode9::Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
      computer.run([10]).output.should eq([1001])
    end
  end

  it "outputs a copy of the program with program 109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" do
    computer = Intcode9::Computer.new("109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99")
    computer.run.output.should eq([109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99])
  end

  it "outputs a 16 digit number with program 1102,34915192,34915192,7,4,7,99,0" do
    computer = Intcode9::Computer.new("1102,34915192,34915192,7,4,7,99,0")
    computer.run.output.first.to_s.size.should eq(16)
  end

  it "outputs 1125899906842624 with program 104,1125899906842624,99" do
    computer = Intcode9::Computer.new("104,1125899906842624,99")
    computer.run.output.first.should eq(1125899906842624_i64)
  end
end