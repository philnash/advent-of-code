class PowerGrid
  @width = 300
  @height = 300
  @power_table = Hash({Int32, Int32}, Int32).new
  getter serial : Int32

  def initialize(@serial)
  end

  def power_level(x, y)
    level = @power_table.fetch({x,y}, nil)
    if level.nil?
      level = (((x + 10) * y + @serial)*(x + 10) / 100 % 10) - 5
      @power_table[{x,y}] = level
    end
    return level
  end

  def get_highest_subgrid_and_size
    grid_size = 1
    max_subgrid_power = -100
    max_subgrid_coords = "?"
    max_grid_size = grid_size
    while grid_size < @width+1
      highest_subgrid_for_this_grid_size = get_highest_subgrid(grid_size)
      if highest_subgrid_for_this_grid_size[1] > max_subgrid_power
        max_subgrid_power = highest_subgrid_for_this_grid_size[1]
        max_subgrid_coords = highest_subgrid_for_this_grid_size[0]
        max_grid_size = grid_size
      end
      puts "#{max_subgrid_power}, #{max_subgrid_coords}, #{max_grid_size}"
      grid_size += 1
    end
  end

  def get_highest_subgrid(grid_size : Int32)
    max_subgrid_power = -100
    max_subgrid_coords = "?"
    (0..@height-grid_size).each do |row|
      (0..@width-grid_size).each do |col|
        power = subgrid_power(col, row, grid_size)
        if power > max_subgrid_power
          max_subgrid_coords = "#{col},#{row}"
          max_subgrid_power = power
        end
      end
    end
    {max_subgrid_coords, max_subgrid_power}
  end

  def subgrid_power(x, y, grid_size)
    total_power = 0
    (y...y+grid_size).each do |row|
      (x...x+grid_size).each do |col|
        total_power += power_level(col, row)
      end
    end
    total_power
  end
end