require "spec"
require "../../07/step.cr"

describe Step do
  it "parses an instruction into two steps" do
    text = "Step C must be finished before step A can begin."
    step1 = Step.parse(text)
    if step1
      step1.id.should eq("A")
      step1.prerequisites.first.id.should eq("C")
    end
  end

  it "parses, sets up and builds the order for a number of steps" do
    inputs = ["Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin."]

    Step.parse_lines(inputs)
    Step.build.should eq("CABDFE")
    Step.reset
  end

  it "parses, sets up and calculates the time for number of steps" do
    inputs = ["Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin."]

    Step.parse_lines(inputs, 0)
    Step.build_in_parallel(2).should eq(15)
  end
end