require "spec"
require "../days/day15.cr"

describe MemoryGame do
  [{4, 0}, {5, 3}, {6, 3}, {7, 1}, {8, 0}, {9, 4}, {10, 0}].each do |turn, result|
    it "calculates the result of #{result} for turn #{turn}" do
      game = MemoryGame.new([0, 3, 6])
      game.turn(turn).should eq(result)
    end
  end
end
