require "spec"
require "../days/day10"

map1 = ".#..#
.....
#####
....#
...##"

map2 = "......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####"

map3 = "#.#...#.#.
.###....#.
.#....#...
##.#.#.#.#
....#.#.#.
.##..###.#
..#...##..
..##....##
......#...
.####.###."

map4 = ".#..#..###
####.###.#
....###.#.
..###.##.#
##.##.#.#.
....###..#
..#.#..#.#
#..#.#.###
.##...##.#
.....#.#.."

map5 = ".#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##"

describe AsteroidMap do
  describe "for first map" do
    
    it "parses all the asteroids" do
      am = AsteroidMap.parse(map1)
      am.asteroids.size.should eq(10)
    end
    it "can show all the detected asteroids for a particular asteroid" do
      am = AsteroidMap.parse(map1)
      number_of_asteroids_detected = [7,7,6,7,7,7,5,7,8,7]
      am.asteroids.each_with_index do |asteroid, index|
        am.detected_asteroids_for(asteroid).size.should eq(number_of_asteroids_detected[index])
      end
    end
    it "finds the most detected asteroids is in position 3, 4" do
      am = AsteroidMap.parse(map1)
      asteroid, count = am.most_asteroids_visible
      {asteroid.x, asteroid.y}.should eq({3,4})
      count.should eq(8)
    end
  end

  describe "for second map" do
    it "finds the most detected asteroids is in position 5, 8" do
      am = AsteroidMap.parse(map2)
      asteroid, count = am.most_asteroids_visible
      {asteroid.x, asteroid.y}.should eq({5,8})
      count.should eq(33)
    end
  end

  describe "for third map" do
    it "finds the most detected asteroids is in position 1, 2" do
      am = AsteroidMap.parse(map3)
      asteroid, count = am.most_asteroids_visible
      {asteroid.x, asteroid.y}.should eq({1,2})
      count.should eq(35)
    end
  end

  describe "for fourth map" do
    it "finds the most detected asteroids is in position 6, 3" do
      am = AsteroidMap.parse(map4)
      asteroid, count = am.most_asteroids_visible
      {asteroid.x, asteroid.y}.should eq({6,3})
      count.should eq(41)
    end
  end

  describe "for fifth map" do
    it "finds the most detected asteroids is in position 11, 13" do
      am = AsteroidMap.parse(map5)
      asteroid, count = am.most_asteroids_visible
      {asteroid.x, asteroid.y}.should eq({11,13})
      count.should eq(210)
    end

    it "finds the order of vaporization" do
      am = AsteroidMap.parse(map5)
      vaporization_order = am.vaporize_asteroids
      {vaporization_order[0].x, vaporization_order[0].y}.should eq({11, 12})
      {vaporization_order[1].x, vaporization_order[1].y}.should eq({12, 1})
      {vaporization_order[2].x, vaporization_order[2].y}.should eq({12, 2})
      {vaporization_order[199].x, vaporization_order[199].y}.should eq({8, 2})
      v = am.vaporized_at(201)
      {v.x, v.y}.should eq({10,9})
    end
  end
end