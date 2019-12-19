def parse_wire(wire)
  wire.split(",").map do |vector|
    match_data = vector.match(/([RDUL])(\d+)/)
    if match_data && match_data[1] && match_data[2]
      {match_data[1], match_data[2].to_i}
    else
      raise "Incorrect data"
    end
  end
end

def create_points(wire)
  current_point = {0, 0}
  current_distance = 0
  current_x, current_y = current_point
  points = Set.new([] of {Int32, Int32})
  distances = Hash({Int32, Int32}, Int32).new
  vectors = parse_wire(wire)
  vectors.each do |direction, distance|
    case direction
    when "U"
      end_point = current_y + distance
      while current_y < end_point
        current_distance += 1
        current_y += 1
        points.add({current_x, current_y})
        distances[{current_x, current_y}] = current_distance unless distances.has_key?({current_x, current_y})
      end
    when "D"
      end_point = current_y - distance
      while current_y > end_point
        current_distance += 1
        current_y -= 1
        points.add({current_x, current_y})
        distances[{current_x, current_y}] = current_distance unless distances.has_key?({current_x, current_y})
      end
    when "R"
      end_point = current_x + distance
      while current_x < end_point
        current_distance += 1
        current_x += 1
        points.add({current_x, current_y})
        distances[{current_x, current_y}] = current_distance unless distances.has_key?({current_x, current_y})
      end
    when "L"
      end_point = current_x - distance
      while current_x > end_point
        current_distance += 1
        current_x -= 1
        points.add({current_x, current_y})
        distances[{current_x, current_y}] = current_distance unless distances.has_key?({current_x, current_y})
      end
    else
    end
  end
  {points, distances}
end

def find_intersections(points_a : Set({Int32, Int32}), points_b : Set({Int32, Int32}))
  intersects = points_a & points_b - [{0,0}]
end

def manhattan_distance(point)
  x, y = point
  x.abs + y.abs
end

def closest_point(points)
  points.map { |p| manhattan_distance(p) }.min
end

def find_closest_intersection(wire_a : String, wire_b : String)
  points_a, distances_a = create_points(wire_a)
  points_b, distances_b = create_points(wire_b)
  intersects = find_intersections(points_a, points_b)
  closest_point(intersects)
end

def closest_intersection_by_distance_travelled(wire_a, wire_b)
  points_a, distances_a = create_points(wire_a)
  points_b, distances_b = create_points(wire_b)
  intersects = find_intersections(points_a, points_b)
  intersects.map { |p| distances_a[p] + distances_b[p] }.min
end