class MoonSystem
  class Vector
    property x : Int32
    property y : Int32
    property z : Int32

    def initialize(@x, @y, @z)
    end

    def +(other_vec)
      Vector.new(x + other_vec.x, y + other_vec.y, z + other_vec.z)
    end
  end

  class Moon
    def self.parse(string)
      values = string[1..-2].split(", ").map { |s| s.split("=") }.map { |s| [s[0], s[1].to_i] }.to_h
      new(values["x"], values["y"], values["z"])
    end

    property pos : Vector
    property vel : Vector

    def initialize(x, y, z)
      @pos = Vector.new(x.to_i, y.to_i, z.to_i)
      @vel = Vector.new(0, 0, 0)
    end

    def apply_velocity
      @pos = @pos + @vel
    end

    def potential_energy
      pos.x.abs + pos.y.abs + pos.z.abs
    end

    def kinetic_energy
      vel.x.abs + vel.y.abs + vel.z.abs
    end

    def energy
      potential_energy * kinetic_energy
    end

    def clone
      Moon.new(pos.x, pos.y, pos.z)
    end

    def to_s
      "pos=<x=#{pos.x}, y=#{pos.y}, z=#{pos.z}>, vel=<x=#{vel.x}, y=#{vel.y}, z=#{vel.z}>"
    end
  end

  getter moons : Array(Moon)

  def initialize(@moons)
  end

  def adjust_velocity(moon1, moon2)
    moon1.vel = moon1.vel + Vector.new(
      velocity_adjustment(moon1.pos.x, moon2.pos.x),
      velocity_adjustment(moon1.pos.y, moon2.pos.y),
      velocity_adjustment(moon1.pos.z, moon2.pos.z)
    )
    moon2.vel = moon2.vel + Vector.new(
      velocity_adjustment(moon2.pos.x, moon1.pos.x),
      velocity_adjustment(moon2.pos.y, moon1.pos.y),
      velocity_adjustment(moon2.pos.z, moon1.pos.z)
    )
  end

  private def velocity_adjustment(x1, x2)
    if x1 > x2
      return -1
    elsif x1 < x2
      return 1
    else
      return 0
    end
  end

  def step(times = 1)
    times.times do |time|
      moons.each_combination(2) { |moons| adjust_velocity(moons[0], moons[1]) }
      moons.each { |moon| moon.apply_velocity }
    end
  end

  def total_energy
    moons.map { |moon| moon.energy }.sum
  end

  def find_system_period
    initial_moons = moons.clone
    periods = [nil, nil, nil] of Nil | Int64
    num_steps = 0_i64
    while periods.any? { |p| p.nil? }
      step
      num_steps += 1
      if periods[0].nil?
        periods[0] = num_steps if moons.map_with_index do |moon, index|
          initial_moon = initial_moons[index]
          moon.pos.x == initial_moon.pos.x && moon.vel.x == initial_moon.vel.x
        end.all?
      end

      if periods[1].nil?
        periods[1] = num_steps if moons.map_with_index do |moon, index|
          initial_moon = initial_moons[index]
          moon.pos.y == initial_moon.pos.y && moon.vel.y == initial_moon.vel.y
        end.all?
      end

      if periods[2].nil?
        periods[2] = num_steps if moons.map_with_index do |moon, index|
          initial_moon = initial_moons[index]
          moon.pos.z == initial_moon.pos.z && moon.vel.z == initial_moon.vel.z
        end.all?
      end
    end
    raise "Something went wrong! #{periods}." if periods.map { |p| p.nil? }.any?
    return periods.reduce(1_i64) { |memo, period| period.nil? ? raise("Something went wrong") : period.lcm(memo) }
  end
end