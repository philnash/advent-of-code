class Maze
  EQUIPMENT = Set.new(["neither", "torch", "climbing gear"])
  getter depth : Int32
  getter target : Tuple(Int32, Int32)
  getter cache

  RISKS = {
    "rocky" => 0,
    "wet" => 1,
    "narrow" => 2
  }

  def initialize(@depth, @target)
    @cache = Array(Array(Int32 | Nil)).new(@target[1]*100) { Array(Int32 | Nil).new(@target[0]*100, nil) }
  end

  def geological_index(x, y)
    result = if @cache[y][x].nil?
      if (x == 0 && y == 0) || (x == target[0] && y == target[1])
        0
      elsif y == 0
        x * 16807
      elsif x == 0
        y * 48271
      else
        erosion_level(x-1, y) * erosion_level(x, y-1)
      end
    else
      @cache[y][x].not_nil!
    end
    @cache[y][x] = result
    return result
  end

  def erosion_level(x, y)
    (geological_index(x, y) + depth) % 20183
  end

  def region_type(x, y)
    case erosion_level(x, y) % 3
    when 0
      "rocky"
    when 1
      "wet"
    else
      "narrow"
    end
  end

  def risk
    y = 0
    risk_total = 0
    while y < target[1] + 1
      x = 0
      while x < target[0] + 1
        risk_total += RISKS[region_type(x,y)]
        x = x + 1
      end
      y = y + 1
    end
    risk_total
  end

  def print(x, y)
    puts ""
    @cache.each_with_index do |row, row_i|
      next if row_i > y
      puts "#{row.first(x).map_with_index { |col, col_i| region_type(col_i, row_i).rjust(6) }.join(" ")}"
    end
  end
end

struct SearchNode
  getter x : Int32
  getter y : Int32
  getter equipment : String

  def initialize(@x, @y, @equipment)
  end

  def ==(other : SearchNode)
    x == other.x && y == other.y && equipment == other.equipment
  end

  def_hash @x, @y, @equipment
end

module MazeSearch

  def self.reconstruct_path(came_from, current)
    path = [current]
    while came_from.keys.includes?(current)
      current = came_from[current]
      path.push(current)
    end
    total_distance = 0
    step = path.shift
    steps = [] of String
    while !path.empty?
      next_step = path.shift
      total_distance += distance(step, next_step)
      if next_step.x < step.x
        steps.push "right"
      elsif next_step.x > step.x
        steps.push "left"
      elsif next_step.y > step.y
        steps.push "up"
      elsif next_step.y < step.y
        steps.push "down"
      else
        steps.push "Change to #{step.equipment}"
      end
      step = next_step
    end
    return total_distance
  end

  def self.a_star(start : SearchNode, goal : SearchNode, maze : Maze)
    closed = Set.new([] of SearchNode)
    open = Set.new([start])

    came_from = Hash(SearchNode, SearchNode).new
    score = Hash(SearchNode, Int32).new(default_value: 100_000)
    score[start] = 0

    estimated_scores = Hash(SearchNode, Int32).new(default_value: 100_000)
    estimated_scores[start] = estimate_score(start, goal, score)

    total_distance = Int32::MAX

    while !open.empty?
      # puts "open: #{open.size}, closed: #{closed.size}"
      current = open.to_a.sort_by { |node| estimated_scores[node] }.first
      # puts "#{current.x}, #{current.y}, #{score[current]}"
      if current == goal
        total_distance = reconstruct_path(came_from, current)
        break
      end

      open.delete(current)
      closed.add(current)

      neighbours(current, maze).each do |neighbour|
        if closed.includes?(neighbour)
          puts "#{neighbour.x},#{neighbour.y},#{neighbour.equipment} in closed"
          next
        end

        potential_score = score[current] + distance(current, neighbour)
        # puts "potential: #{potential_score}"

        if !open.includes?(neighbour)
          open.add(neighbour)
        elsif potential_score >= score[neighbour]
          next
        end

        came_from[neighbour] = current
        score[neighbour] = potential_score
        estimated_scores[neighbour] = score[neighbour] + estimate_score(neighbour, goal, score)
      end
    end
    return total_distance
  end

  def self.estimate_score(node : SearchNode, goal : SearchNode, scores : Hash(SearchNode, Int32)) : Int32
    tool_change = node.equipment == goal.equipment ? 0 : 7
    scores.fetch(node, 0) + manhattan_distance(node, goal) + tool_change
  end

  def self.manhattan_distance(start : SearchNode, goal : SearchNode)
    (start.x - goal.x).abs + (start.y - goal.y).abs
  end

  def self.neighbours(node, maze)
    neighbours = [
      SearchNode.new(node.x - 1, node.y, node.equipment),
      SearchNode.new(node.x + 1, node.y, node.equipment),
      SearchNode.new(node.x, node.y - 1, node.equipment),
      SearchNode.new(node.x, node.y + 1, node.equipment)
    ]
    neighbours.concat((Maze::EQUIPMENT - [node.equipment]).map do |equipment|
      SearchNode.new(node.x, node.y, equipment)
    end)
    return neighbours.select do |neighbour|
      if neighbour.x < 0 || neighbour.y < 0
        false
      else
        case maze.region_type(neighbour.x, neighbour.y)
        when "rocky"
          neighbour.equipment == "climbing gear" || neighbour.equipment == "torch"
        when "wet"
          neighbour.equipment == "climbing gear" || neighbour.equipment == "neither"
        else
          neighbour.equipment == "neither" || neighbour.equipment == "torch"
        end
      end
    end
  end

  def self.distance(node, other)
    manhattan_distance(node, other) == 0 ? 7 : 1
  end
end