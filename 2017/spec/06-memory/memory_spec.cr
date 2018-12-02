require "spec"
require "../../06-memory/memory"

describe "Memory" do
  it "initialises with 0, 2, 7, 0" do
    initial_state = [0, 2, 7, 0]
    memory = Memory.new(initial_state)
    memory.state.should eq(initial_state)
  end

  it "should reallocate the first round to 2, 4, 1, 2" do
    initial_state = [0, 2, 7, 0]
    memory = Memory.new(initial_state)
    memory.reallocate!
    memory.finished?.should be_false
    memory.state.should eq([2, 4, 1, 2])
  end

  it "should reallocate the second round to 3, 1, 2, 3" do
    initial_state = [0, 2, 7, 0]
    memory = Memory.new(initial_state)
    memory.reallocate!.reallocate!
    memory.finished?.should be_false
    memory.state.should eq([3, 1, 2, 3])
  end

  it "should reallocate the fifth round to 2, 4, 1, 2 and be finished" do
    initial_state = [0, 2, 7, 0]
    memory = Memory.new(initial_state)
    memory.reallocate!.reallocate!.reallocate!.reallocate!.reallocate!
    memory.finished?.should be_true
    memory.state.should eq([2, 4, 1, 2])
    memory.counter.should eq(5)
  end

  it "should calculate number of reallocations to optimum" do
    memory = Memory.new([0, 2, 7, 0])
    memory.reallocate_until_optimal!
    memory.counter.should eq(5)
  end

  it "should count the loop length of the optimum reallocation" do
    memory = Memory.new([0, 2, 7, 0])
    memory.reallocate_until_optimal!
    memory.reallocation_loop.should eq(4)
  end
end
