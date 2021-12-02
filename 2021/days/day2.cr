class Submarine
  getter :horizontal
  getter :depth

  def initialize(@horizontal = 0, @depth = 0)
  end

  def apply_instructions(instructions : Array(String))
    instructions.each do |instruction|
      match_data = instruction.match(/^(forward|up|down) (\d+)$/)
      if match_data
        if match_data[1] == "forward"
          self.forward(match_data[2].to_i)
        elsif match_data[1] == "up"
          self.up(match_data[2].to_i)
        else
          self.down(match_data[2].to_i)
        end
      end
    end
  end
end

class Dive < Submarine
  def forward(distance : Int32)
    @horizontal += distance
  end

  def down(distance : Int32)
    @depth += distance
  end

  def up(distance : Int32)
    @depth -= distance
  end
end

class DiveWithAim < Submarine
  def initialize(@horizontal = 0, @depth = 0, @aim = 0)
    super(@horizontal, @depth)
  end

  def forward(distance : Int32)
    @horizontal += distance
    @depth += @aim * distance
  end

  def down(units : Int32)
    @aim += units
  end

  def up(units : Int32)
    @aim -= units
  end
end
