class Timetable
  def self.parse_timetable(input : String)
    time, buses = input.split("\n")
    new(buses.split(",").select { |b| b != "x" }.map(&.to_i).map { |id| Bus.new(id) }, time.to_i)
  end

  def initialize(@buses : Array(Bus), @time : Int32)
  end

  def earliest_bus
    bus = @buses.min_by { |bus| bus.next_departure_after(@time) }
    (bus.next_departure_after(@time) - @time) * bus.id
  end

  def self.win_gold_coin(pattern : String)
    buses_and_offsets = pattern.split(",").map_with_index do |char, index|
      {char.to_i64, index} unless char == "x"
    end.reject(Nil)
    time = 0_i64
    time_offset = 1_i64
    buses_and_offsets.each do |(bus, offset)|
      while (time + offset) % bus != 0
        time += time_offset
      end
      time_offset *= bus
    end
    time
  end
end

class Bus
  getter id : Int32

  def initialize(@id)
  end

  def next_departure_after(time)
    (time // id + 1)*id
  end
end
