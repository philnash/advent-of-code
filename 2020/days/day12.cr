class Ship
  def initialize
  end

  def travel(input)
    direction = 90
    x = 0
    y = 0
    input.split("\n").each do |movement|
      instruction = movement[0]
      distance = movement[1..-1].to_i
      if instruction == 'F'
        instruction = direction_to_instruction(direction)
      end
      case instruction
      when 'N'
        y = y + distance
      when 'S'
        y = y - distance
      when 'E'
        x = x + distance
      when 'W'
        x = x - distance
      when 'R'
        direction = (direction + distance) % 360
      when 'L'
        direction = (direction - distance) % 360
      end
    end
    x.abs + y.abs
  end

  def waypoint_travel(input)
    waypoint_x = 10
    waypoint_y = 1
    x = 0
    y = 0
    input.split("\n").each do |movement|
      instruction = movement[0]
      distance = movement[1..-1].to_i
      case instruction
      when 'F'
        x = x + waypoint_x * distance
        y = y + waypoint_y * distance
      when 'N'
        waypoint_y = waypoint_y + distance
      when 'S'
        waypoint_y = waypoint_y - distance
      when 'E'
        waypoint_x = waypoint_x + distance
      when 'W'
        waypoint_x = waypoint_x - distance
      when 'R'
        (distance//90).times do
          waypoint_x, waypoint_y = [waypoint_y, -waypoint_x]
        end
      when 'L'
        (distance//90).times do
          waypoint_x, waypoint_y = [-waypoint_y, waypoint_x]
        end
      end
    end
    x.abs + y.abs
  end

  private def direction_to_instruction(direction)
    case direction
    when 0
      'N'
    when 90
      'E'
    when 180
      'S'
    else
      'W'
    end
  end
end
