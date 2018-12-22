require "spec"
require "../../22/maze.cr"

describe Maze do
  describe "at 0,0" do
    it "calculates geological index" do
      Maze.new(510, {10,10}).geological_index(0,0).should eq(0)
    end
    it "calculates erosion level" do
      Maze.new(510, {10,10}).erosion_level(0,0).should eq(510)
    end
    it "calculates region type" do
      Maze.new(510, {10,10}).region_type(0,0).should eq("rocky")
    end
  end
  describe "at the target" do
    it "calcualates geological index" do
      Maze.new(510, {10,10}).geological_index(10,10).should eq(0)
    end
    it "calculates erosion level" do
      Maze.new(510, {10,10}).erosion_level(0,0).should eq(510)
    end
    it "calculates region type" do
      Maze.new(510, {10,10}).region_type(0,0).should eq("rocky")
    end
  end

  describe "at 1, 0" do
    it "calcualates geological index" do
      Maze.new(510, {10,10}).geological_index(1,0).should eq(16807)
    end
    it "calculates erosion level" do
      Maze.new(510, {10,10}).erosion_level(1,0).should eq(17317)
    end
    it "calculates region type" do
      Maze.new(510, {10,10}).region_type(1,0).should eq("wet")
    end
  end

  describe "at 0,1" do
    it "calcualates geological index" do
      Maze.new(510, {10,10}).geological_index(0,1).should eq(48271)
    end
    it "calculates erosion level" do
      Maze.new(510, {10,10}).erosion_level(0,1).should eq(8415)
    end
    it "calculates region type" do
      Maze.new(510, {10,10}).region_type(0,1).should eq("rocky")
    end
  end

  describe "at 1,1" do
    it "calcualates geological index" do
      Maze.new(510, {10,10}).geological_index(1,1).should eq(145722555)
    end
    it "calculates erosion level" do
      maze = Maze.new(510, {10,10})
      maze.erosion_level(1,1).should eq(1805)
    end
    it "calculates region type" do
      Maze.new(510, {10,10}).region_type(1,1).should eq("narrow")
    end
  end

  describe "distance" do
    it "should calculate the distance to target" do
      maze = Maze.new(510, {10,10})
      start = SearchNode.new(0, 0, "torch")
      target = SearchNode.new(10, 10, "torch")
      result = MazeSearch.a_star(start, target, maze).should eq(45)
    end

    it "should get viable neighbours" do
      maze = Maze.new(510, {10,10})
      start = SearchNode.new(0, 0, "torch")
      MazeSearch.neighbours(start, maze).should contain(SearchNode.new(0, 0, "climbing gear"))
      MazeSearch.neighbours(start, maze).should contain(SearchNode.new(0, 1, "torch"))
    end

    it "should get viable neighbours" do
      maze = Maze.new(510, {10,10})
      start = SearchNode.new(1, 1, "torch")
      MazeSearch.neighbours(start, maze).should contain(SearchNode.new(0, 1, "torch"))
      MazeSearch.neighbours(start, maze).should contain(SearchNode.new(1, 1, "neither"))
    end

    it "should get distance back to start" do
      maze = Maze.new(510, {10,10})
      start = SearchNode.new(0, 0, "torch")
      target = SearchNode.new(1, 1, "torch")
      rocky = SearchNode.new(0, 1, "torch")
      came_from = { target => rocky, rocky => start }
      MazeSearch.reconstruct_path(came_from, target).should eq(2)
    end
  end
end