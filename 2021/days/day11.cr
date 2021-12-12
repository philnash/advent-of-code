class Octopus
  getter energy : Int32
  getter x : Int32
  getter y : Int32
  @has_flashed : Bool

  def initialize(@energy, @x, @y)
    @has_flashed = false
  end

  def step
    @energy += 1
    self
  end

  def flash!
    @has_flashed = true
  end

  def settled?
    @energy <= 9 || @energy > 9 && @has_flashed
  end

  def reset
    @energy = 0 if @energy > 9
    @has_flashed = false
  end
end

class OctopusGrid
  @octopi : Array(Array(Octopus))

  def initialize(energies : Array(Array(Int32)))
    @octopi = energies.map_with_index { |row, y| row.map_with_index { |col, x| Octopus.new(col, x, y) } }
  end

  def [](x, y)
    return nil unless x >= 0 && x < @octopi.size && y >= 0 && y < @octopi.size
    @octopi[y][x]
  end

  def step
    flashes = 0
    @octopi.each { |row| row.map { |octopus| octopus.step } }
    to_flash = @octopi.flatten.reject { |o| o.settled? }
    while to_flash.size > 0
      to_flash.each do |octopus|
        [
          self[octopus.x - 1, octopus.y - 1],
          self[octopus.x, octopus.y - 1],
          self[octopus.x + 1, octopus.y - 1],
          self[octopus.x - 1, octopus.y],
          self[octopus.x + 1, octopus.y],
          self[octopus.x - 1, octopus.y + 1],
          self[octopus.x, octopus.y + 1],
          self[octopus.x + 1, octopus.y + 1],
        ].compact.each { |oc| oc.step }
        flashes += 1
        octopus.flash!
      end
      to_flash = @octopi.flatten.reject { |o| o.settled? }
    end
    @octopi.each { |row| row.each { |o| o.reset } }
    flashes
  end

  def step(count : Int32)
    flashes = 0
    count.times do
      flashes += self.step
    end
    flashes
  end

  def step_until_synchronised
    count = 1
    flashes = self.step
    while flashes != 100
      flashes = self.step
      count += 1
    end
    count
  end
end
