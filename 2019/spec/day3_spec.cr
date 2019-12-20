require "spec"
require "../days/day3"

describe "#parse_wire" do
  it "turns a string into vectors" do
    vectors = parse_wire("R8,U5,L5,D3")
    vectors.should eq([{"R", 8}, {"U", 5}, {"L", 5}, {"D", 3}])
  end
end

describe "create_points" do
  it "turns vectors into points in a set" do
    points, distances = create_points("R8,U5,L5,D3")
    points.should eq(Set.new([{1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {7, 0}, {8, 0}, {8, 1}, {8, 2}, {8, 3}, {8, 4}, {8, 5}, {3, 5}, {4, 5}, {5, 5}, {6, 5}, {7, 5}, {3, 2}, {3, 3}, {3, 4}]))
    distances.should eq({ {1, 0} => 1, {2, 0} => 2, {3, 0} => 3, {4, 0} => 4, {5, 0} => 5, {6, 0} => 6, {7, 0} => 7, {8, 0} => 8, {8, 1} => 9, {8, 2} => 10, {8, 3} => 11, {8, 4} => 12, {8, 5} => 13, {7, 5} => 14, {6, 5} => 15, {5, 5} => 16, {4, 5} => 17, {3, 5} => 18, {3, 4} => 19, {3, 3} => 20, {3, 2} => 21} )
  end
end

describe "find_intersections" do
  it "finds all common points" do
    points_a = Set.new([{1,0},{2,0}])
    points_b = Set.new([{1,0},{3,0}])
    find_intersections(points_a, points_b).should eq(Set.new([{1,0}]))
  end

  it "parses, creates points and finds the intersections" do
    points_a, _ = create_points("R8,U5,L5,D3")
    points_b, _ = create_points("U7,R6,D4,L4")
    find_intersections(points_a, points_b).should eq(Set.new([{3,3}, {6,5}]))
  end
end

describe "manhattan distance" do
  it "is the sum of the absolute values of x and y" do
    manhattan_distance({0,0}).should eq(0)
    manhattan_distance({3,3}).should eq(6)
  end
end

describe "closest manhattan distance" do
  it "is the minimum manhattan distance" do
    closest_point(Set.new([{3,3}, {6,5}])).should eq(6)
  end
end

describe "closest point from wires" do
  it "is 6" do
    find_closest_intersection("R8,U5,L5,D3", "U7,R6,D4,L4").should eq(6)
  end

  it "is 159" do
    find_closest_intersection("R75,D30,R83,U83,L12,D49,R71,U7,L72" ,"U62,R66,U55,R34,D71,R55,D58,R83").should eq(159)
  end

  it "is 135" do
    find_closest_intersection("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7").should eq(135)
  end
end

describe "closest point from distance travelled" do
  it "is 30" do
    closest_intersection_by_distance_travelled("R8,U5,L5,D3", "U7,R6,D4,L4").should eq(30)
  end

  it "is 610" do
    closest_intersection_by_distance_travelled("R75,D30,R83,U83,L12,D49,R71,U7,L72" ,"U62,R66,U55,R34,D71,R55,D58,R83").should eq(610)
  end

  it "is 410" do
    closest_intersection_by_distance_travelled("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7").should eq(410)
  end
end