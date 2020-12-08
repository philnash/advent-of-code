require "spec"
require "../days/day8.cr"

input = ["nop +0", "acc +1", "jmp +4", "acc +3", "jmp -3", "acc -99", "acc +1", "jmp -4", "acc +6"]

describe Console do
  it "returns the accumulator and whether the program finished correctly" do
    Console.new.process_instructions(input).should eq({5, false})
  end

  it "returns the accumulator when the program finishes correctly" do
    Console.new.find_incorrect_instruction(input).should eq(8)
  end
end
