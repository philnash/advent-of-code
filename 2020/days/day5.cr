class BoardingPass
  getter row : Array(String)
  getter seat : Array(String)

  def initialize(input : String)
    @row = input[0..6].split("")
    @seat = input[7..9].split("")
  end

  def row_number
    search(@row, 0, 127, "F")
  end

  def seat_number
    search(@seat, 0, 7, "L")
  end

  def seat_id
    row_number * 8 + seat_number
  end

  private def search(input, min, max, lower_char)
    input.each do |choice|
      if choice == lower_char
        max = (max + min) // 2
      else
        min = (max + min) // 2 + 1
      end
    end
    min
  end
end

class Seats
  getter seat_ids : Array(Int32)

  def initialize(input)
    @seat_ids = input.map { |directions| BoardingPass.new(directions).seat_id }
  end

  def highest_id
    seat_ids.max
  end

  def missing_seat
    seats = @seat_ids.sort
    first_seat = seats.shift
    seats.reduce(first_seat) do |last_seat, this_seat|
      return last_seat + 1 if last_seat + 1 != this_seat
      this_seat
    end
  end
end
