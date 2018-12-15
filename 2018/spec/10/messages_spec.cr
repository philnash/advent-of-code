require "spec"
require "../../10/messages.cr"

describe Point do
  it "parses out a position and velocity" do
    text = "position=< 9,  1> velocity=< 0,  2>"
    point = Point.parse(text)
    point.position.should eq({9, 1})
    point.velocity.should eq({0, 2})
  end

  it "parses out a position and velocity with negatives" do
    text = "position=< 3, -2> velocity=<-1,  1>"
    point = Point.parse(text)
    point.position.should eq({3, -2})
    point.velocity.should eq({-1, 1})
  end

  it "updates the position by the velocity" do
    point = Point.new({0, 0}, {1, 1})
    point.position.should eq({0, 0})
    point.update!
    point.position.should eq({1, 1})
    point.update!
    point.position.should eq({2, 2})
  end
end

input = ["position=< 9,  1> velocity=< 0,  2>",
         "position=< 7,  0> velocity=<-1,  0>",
         "position=< 3, -2> velocity=<-1,  1>",
         "position=< 6, 10> velocity=<-2, -1>",
         "position=< 2, -4> velocity=< 2,  2>",
         "position=<-6, 10> velocity=< 2, -2>",
         "position=< 1,  8> velocity=< 1, -1>",
         "position=< 1,  7> velocity=< 1,  0>",
         "position=<-3, 11> velocity=< 1, -2>",
         "position=< 7,  6> velocity=<-1, -1>",
         "position=<-2,  3> velocity=< 1,  0>",
         "position=<-4,  3> velocity=< 2,  0>",
         "position=<10, -3> velocity=<-1,  1>",
         "position=< 5, 11> velocity=< 1, -2>",
         "position=< 4,  7> velocity=< 0, -1>",
         "position=< 8, -2> velocity=< 0,  1>",
         "position=<15,  0> velocity=<-2,  0>",
         "position=< 1,  6> velocity=< 1,  0>",
         "position=< 8,  9> velocity=< 0, -1>",
         "position=< 3,  3> velocity=<-1,  1>",
         "position=< 0,  5> velocity=< 0, -1>",
         "position=<-2,  2> velocity=< 2,  0>",
         "position=< 5, -2> velocity=< 1,  2>",
         "position=< 1,  4> velocity=< 2,  1>",
         "position=<-2,  7> velocity=< 2, -2>",
         "position=< 3,  6> velocity=<-1, -1>",
         "position=< 5,  0> velocity=< 1,  0>",
         "position=<-6,  0> velocity=< 2,  0>",
         "position=< 5,  9> velocity=< 1, -2>",
         "position=<14,  7> velocity=<-2,  0>",
         "position=<-3,  6> velocity=< 2, -1>"]

result = "........#.............
................#.....
.........#.#..#.......
......................
#..........#.#.......#
...............#......
....#.................
..#.#....#............
.......#..............
......#...............
...#...#.#...#........
....#..#..#.........#.
.......#..............
...........#..#.......
#...........#.........
...#.......#.........."

result2 = "........#....#....
......#.....#.....
#.........#......#
..................
....#.............
..##.........#....
....#.#...........
...##.##..#.......
......#.#.........
......#...#.....#.
#...........#.....
..#.....#.#......."

describe Sky do
  it "should draw the sky" do
    points = input.map { |text| Point.parse(text) }
    sky = Sky.new(points)
    sky.draw.should eq(result)
    sky.tick
    sky.draw.should eq(result2)
  end
end
