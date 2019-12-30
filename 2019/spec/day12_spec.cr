require "spec"
require "../days/day12"

describe MoonSystem::Moon do
  it "parses the 3d position" do
    moon = MoonSystem::Moon.parse("<x=-1, y=0, z=2>")
    moon.pos.x.should eq(-1)
    moon.pos.y.should eq(0)
    moon.pos.z.should eq(2)
  end

  it "starts with a velocity of 0 in each direction" do
    moon = MoonSystem::Moon.parse("<x=-1, y=0, z=2>")
    moon.vel.x.should eq(0)
    moon.vel.y.should eq(0)
    moon.vel.z.should eq(0)
  end

  it "prints out in a pretty way" do
    moon = MoonSystem::Moon.parse("<x=-1, y=0, z=2>")
    moon.to_s.should eq("pos=<x=-1, y=0, z=2>, vel=<x=0, y=0, z=0>")
  end
end

describe MoonSystem do
  it "initializes with moons" do
    moon_system = MoonSystem.new([MoonSystem::Moon.new(1,2,3)])
    moon_system.moons.size.should eq(1)
  end

  it "adjusts velocity with gravity between two moons" do
    moon1 = MoonSystem::Moon.parse("<x=-1, y=0, z=2>")
    moon2 = MoonSystem::Moon.parse("<x=2, y=-10, z=-7>")
    moon_system = MoonSystem.new([moon1, moon2])
    moon_system.adjust_velocity(moon1, moon2)
    moon1.vel.x.should eq(1)
    moon1.vel.y.should eq(-1)
    moon1.vel.z.should eq(-1)
    moon2.vel.x.should eq(-1)
    moon2.vel.y.should eq(1)
    moon2.vel.z.should eq(1)
  end

  it "adjusts all moons after one step" do
    moons = [
      MoonSystem::Moon.parse("<x=-1, y=0, z=2>"),
      MoonSystem::Moon.parse("<x=2, y=-10, z=-7>"),
      MoonSystem::Moon.parse("<x=4, y=-8, z=8>"),
      MoonSystem::Moon.parse("<x=3, y=5, z=-1>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.step
    moons_after_step1 = "pos=<x=2, y=-1, z=1>, vel=<x=3, y=-1, z=-1>
pos=<x=3, y=-7, z=-4>, vel=<x=1, y=3, z=3>
pos=<x=1, y=-7, z=5>, vel=<x=-3, y=1, z=-3>
pos=<x=2, y=2, z=0>, vel=<x=-1, y=-3, z=1>"
    moon_system.moons.map { |m| m.to_s }.join("\n").should eq(moons_after_step1)
  end

  it "adjusts all moons after two steps" do
    moons = [
      MoonSystem::Moon.parse("<x=-1, y=0, z=2>"),
      MoonSystem::Moon.parse("<x=2, y=-10, z=-7>"),
      MoonSystem::Moon.parse("<x=4, y=-8, z=8>"),
      MoonSystem::Moon.parse("<x=3, y=5, z=-1>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.step(2)
    moons_after_step2 = "pos=<x=5, y=-3, z=-1>, vel=<x=3, y=-2, z=-2>
pos=<x=1, y=-2, z=2>, vel=<x=-2, y=5, z=6>
pos=<x=1, y=-4, z=-1>, vel=<x=0, y=3, z=-6>
pos=<x=1, y=-4, z=2>, vel=<x=-1, y=-6, z=2>"
    moon_system.moons.map { |m| m.to_s }.join("\n").should eq(moons_after_step2)
  end

  it "adjusts all moons after 3 steps" do
    moons = [
      MoonSystem::Moon.parse("<x=-1, y=0, z=2>"),
      MoonSystem::Moon.parse("<x=2, y=-10, z=-7>"),
      MoonSystem::Moon.parse("<x=4, y=-8, z=8>"),
      MoonSystem::Moon.parse("<x=3, y=5, z=-1>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.step(3)
    moons_after_step3 = "pos=<x=5, y=-6, z=-1>, vel=<x=0, y=-3, z=0>
pos=<x=0, y=0, z=6>, vel=<x=-1, y=2, z=4>
pos=<x=2, y=1, z=-5>, vel=<x=1, y=5, z=-4>
pos=<x=1, y=-8, z=2>, vel=<x=0, y=-4, z=0>"
    moon_system.moons.map { |m| m.to_s }.join("\n").should eq(moons_after_step3)
  end

  it "adjusts all moons after 10 steps" do
    moons = [
      MoonSystem::Moon.parse("<x=-1, y=0, z=2>"),
      MoonSystem::Moon.parse("<x=2, y=-10, z=-7>"),
      MoonSystem::Moon.parse("<x=4, y=-8, z=8>"),
      MoonSystem::Moon.parse("<x=3, y=5, z=-1>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.step(10)
    moons_after_step10 = "pos=<x=2, y=1, z=-3>, vel=<x=-3, y=-2, z=1>
pos=<x=1, y=-8, z=0>, vel=<x=-1, y=1, z=3>
pos=<x=3, y=-6, z=1>, vel=<x=3, y=2, z=-3>
pos=<x=2, y=0, z=4>, vel=<x=1, y=-1, z=-1>"
    moon_system.moons.map { |m| m.to_s }.join("\n").should eq(moons_after_step10)
  end

  it "calculates the correct potential and kinetic energies and the total" do
    moons = [
      MoonSystem::Moon.parse("<x=-1, y=0, z=2>"),
      MoonSystem::Moon.parse("<x=2, y=-10, z=-7>"),
      MoonSystem::Moon.parse("<x=4, y=-8, z=8>"),
      MoonSystem::Moon.parse("<x=3, y=5, z=-1>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.step(10)
    total_energy_per_moon = [36, 45, 80, 18]
    moons.each_with_index do |moon, index|
      (moon.potential_energy * moon.kinetic_energy).should eq(total_energy_per_moon[index])
    end
    moon_system.total_energy.should eq(179)
  end

  it "calculates the period of the system" do
    moons = [
      MoonSystem::Moon.parse("<x=-1, y=0, z=2>"),
      MoonSystem::Moon.parse("<x=2, y=-10, z=-7>"),
      MoonSystem::Moon.parse("<x=4, y=-8, z=8>"),
      MoonSystem::Moon.parse("<x=3, y=5, z=-1>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.find_system_period.should eq(2772_i64)
  end

  it "calculates a the period of the system with a high period" do
    moons = [
      MoonSystem::Moon.parse("<x=-8, y=-10, z=0>"),
      MoonSystem::Moon.parse("<x=5, y=5, z=10>"),
      MoonSystem::Moon.parse("<x=2, y=-7, z=3>"),
      MoonSystem::Moon.parse("<x=9, y=-8, z=-3>")
    ]
    moon_system = MoonSystem.new(moons)
    moon_system.find_system_period.should eq(4686774924_i64)
  end
end