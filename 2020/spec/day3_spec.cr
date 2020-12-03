require "spec"
require "../days/day3.cr"

input = ["..##.......",
         "#...#...#..",
         ".#....#..#.",
         "..#.#...#.#",
         ".#...##..#.",
         "..#.##.....",
         ".#.#.#....#",
         ".#........#",
         "#.##...#...",
         "#...##....#",
         ".#..#...#.#"]

describe "" do
  it "traverses the map" do
    map = TobogganTrajectory.new(input)
    map.traverse(3, 1).should eq(7)
  end

  it "tests different paths across the map" do
    map = TobogganTrajectory.new(input)
    map.test_paths([{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]).should eq(336)
  end
end
