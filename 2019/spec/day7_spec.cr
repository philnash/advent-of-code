require "spec"
require "../days/day7"

describe AmplifierGroup do
  it "creates all the available setting combinations" do
    AmplifierGroup.new(2).signal_permutations.should eq([[0,1], [1,0]])
    AmplifierGroup.new(3).signal_permutations.should eq([[0,1,2], [0,2,1], [1,0,2], [1,2,0], [2,0,1], [2,1,0]])
  end

  describe "max thruster signal for" do
    it "is 43210 for 3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0" do
      ag = AmplifierGroup.new(5).find_max_output("3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
      ag.should eq({43210, [4,3,2,1,0]})
    end

    it "is 43210 for 3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0" do
      ag = AmplifierGroup.new(5).find_max_output("3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
      ag.should eq({43210, [4,3,2,1,0]})
    end
  end

  describe "max thruster signal in feedback formation" do
    it "is 139629729 for 3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5" do
      ag = AmplifierGroup.new(5).find_max_output_for_feedback_loop("3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5")
      ag.should eq({139629729, [9,8,7,6,5]})
    end

    it "is 18216 for 3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10" do
      ag = AmplifierGroup.new(5).find_max_output_for_feedback_loop("3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10")
      ag.should eq({18216, [9,7,8,5,6]})
    end
  end
end

describe Intcode7 do
  it "turns 1,0,0,0,99 into 2,0,0,0,99" do
    computer = Intcode7::Computer.new("1,0,0,0,99")
    computer.run.to_s.should eq("2,0,0,0,99")
  end

  it "turns 2,3,0,3,99 into 2,3,0,6,99" do
    computer = Intcode7::Computer.new("2,3,0,3,99")
    computer.run.to_s.should eq("2,3,0,6,99")
  end

  it "turns 2,4,4,5,99,0 into 2,4,4,5,99,9801" do
    computer = Intcode7::Computer.new("2,4,4,5,99,0")
    computer.run.to_s.should eq("2,4,4,5,99,9801")
  end

  it "turns 1,1,1,4,99,5,6,0,99 into 30,1,1,4,2,5,6,0,99" do
    computer = Intcode7::Computer.new("1,1,1,4,99,5,6,0,99")
    computer.run.to_s.should eq("30,1,1,4,2,5,6,0,99")
  end

  it "turns 1,9,10,3,2,3,11,0,99,30,40,50 into 3500,9,10,70,2,3,11,0,99,30,40,50" do
    computer = Intcode7::Computer.new("1,9,10,3,2,3,11,0,99,30,40,50")
    computer.run.to_s.should eq("3500,9,10,70,2,3,11,0,99,30,40,50")
  end

  it "takes an input and places it in memory" do
    computer = Intcode7::Computer.new("3,3,99,0")
    computer.run([25]).to_s.should eq("3,3,99,25")
  end

  it "outputs to an array" do
    computer = Intcode7::Computer.new("4, 3, 99, 2")
    computer.run.output.should eq([2])
  end

  it "outputs 1 if the input is 8" do
    computer = Intcode7::Computer.new("3,9,8,9,10,9,4,9,99,-1,8")
    computer.run([8]).output.should eq([1])
  end

  describe "with the program 3,9,8,9,10,9,4,9,99,-1,8" do
    it "outputs 0 if the input is not 8" do
      computer = Intcode7::Computer.new("3,9,8,9,10,9,4,9,99,-1,8")
      computer.run([7]).output.should eq([0])
    end

    it "outputs 1 if the input is 8" do
      computer = Intcode7::Computer.new("3,3,1108,-1,8,3,4,3,99")
      computer.run([8]).output.should eq([1])
    end
  end

  describe "with the program 3,9,7,9,10,9,4,9,99,-1,8" do
    it "outputs 1 if the input is less than 8" do
      computer = Intcode7::Computer.new("3,9,7,9,10,9,4,9,99,-1,8")
      computer.run([7]).output.should eq([1])
    end

    it "outputs 0 if the input is not less than 8" do
      computer = Intcode7::Computer.new("3,9,7,9,10,9,4,9,99,-1,8")
      computer.run([8]).output.should eq([0])
    end
  end

  describe "with the program 3,3,1108,-1,8,3,4,3,99" do
    it "outputs 1 if the program is equal to 8" do
      computer = Intcode7::Computer.new("3,3,1108,-1,8,3,4,3,99")
      computer.run([8]).output.should eq([1])
    end

    it "outputs 0 if the program is not equal to 8" do
      computer = Intcode7::Computer.new("3,3,1108,-1,8,3,4,3,99")
      computer.run([9]).output.should eq([0])
    end
  end

  describe "with the program 3,3,1107,-1,8,3,4,3,99" do
    it "outputs 1 if the input is less than 8" do
      computer = Intcode7::Computer.new("3,3,1107,-1,8,3,4,3,99")
      computer.run([7]).output.should eq([1])
    end

    it "outputs 0 if the input is not less than 8" do
      computer = Intcode7::Computer.new("3,3,1107,-1,8,3,4,3,99")
      computer.run([8]).output.should eq([0])
    end
  end

  describe "with the program 3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9" do
    it "outputs 0 if the input is 0" do
      computer = Intcode7::Computer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
      computer.run([0]).output.should eq([0])
    end

    it "outputs 1 if the input is not 0" do
      computer = Intcode7::Computer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
      computer.run([10]).output.should eq([1])
    end
  end

  describe "with the program 3,3,1105,-1,9,1101,0,0,12,4,12,99,1" do
    it "outputs 0 if the input is 0" do
      computer = Intcode7::Computer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
      computer.run([0]).output.should eq([0])
    end

    it "outputs 1 if the input is not 0" do
      computer = Intcode7::Computer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
      computer.run([10]).output.should eq([1])
    end
  end

  describe "with the program 3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99" do
    it "outputs 999 if the input is less than 8" do
      computer = Intcode7::Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
      computer.run([5]).output.should eq([999])
    end

    it "outputs 1000 if the input is 8" do
      computer = Intcode7::Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
      computer.run([8]).output.should eq([1000])
    end

    it "outputs 1001 if the input is greater than 8" do
      computer = Intcode7::Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
      computer.run([10]).output.should eq([1001])
    end
  end
end