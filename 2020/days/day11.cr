class WaitingSeats
  @seats : Array(Array(String))
  @height : Int32
  @width : Int32

  def initialize(input : String)
    @seats = input.split("\n").map { |line| line.split("") }
    @height = @seats.size
    @width = @seats.first.size
  end

  def seat(x, y)
    return "." if x < 0 || x >= @width || y < 0 || y >= @height
    @seats[y][x]
  end

  def set_seat(x, y, state)
    @seats[y][x] = state
  end

  def adjacent_seats(x, y)
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
    ].map { |(x, y)| seat(x, y) }
  end

  def visible_adjacent_seats(x, y)
    [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1},
    ].map do |(mov_x, mov_y)|
      new_x = x + mov_x
      new_y = y + mov_y
      seat = seat(new_x, new_y)
      while seat == "." && new_x >= 0 && new_x < @width && new_y < @height && new_y >= 0
        new_x = new_x + mov_x
        new_y = new_y + mov_y
        seat = seat(new_x, new_y)
      end
      seat
    end
  end

  def cycle_part_1
    @seats = @seats.map_with_index { |row, y|
      row.map_with_index { |seat, x|
        adjacent = adjacent_seats(x, y)
        new_seat = seat
        if seat == "L" && adjacent.all? { |seat| seat == "L" || seat == "." }
          new_seat = "#"
        elsif seat == "#" && adjacent.select { |seat| seat == "#" }.size > 3
          new_seat = "L"
        end
        new_seat
      }
    }
    @seats
  end

  def cycle_part_2
    @seats = @seats.map_with_index { |row, y|
      row.map_with_index { |seat, x|
        adjacent = visible_adjacent_seats(x, y)
        new_seat = seat
        if seat == "L" && adjacent.all? { |seat| seat == "L" || seat == "." }
          new_seat = "#"
        elsif seat == "#" && adjacent.select { |seat| seat == "#" }.size > 4
          new_seat = "L"
        end
        new_seat
      }
    }
    @seats
  end

  def cycle_part_1_until_stable
    current_seats = @seats.dup
    next_seats = cycle_part_1
    while (next_seats != current_seats)
      current_seats = next_seats
      next_seats = cycle_part_1
    end
  end

  def cycle_part_2_until_stable
    current_seats = @seats.dup
    next_seats = cycle_part_2
    while (next_seats != current_seats)
      current_seats = next_seats
      next_seats = cycle_part_2
    end
  end

  def print
    @seats.map { |row| row.join("") }.join("\n")
  end

  def empty_seats
    @seats.flatten.select { |s| s == "L" }.size
  end

  def occupied_seats
    @seats.flatten.select { |s| s == "#" }.size
  end
end
