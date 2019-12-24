require "spec"
require "../days/day6"

map = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L".split("\n")

map2 = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN".split("\n")

describe OrbitMap do
  describe "finding orbits" do
    orbit_map = OrbitMap.new(map)
    objects = orbit_map.objects
    it "creates object D which orbits C directly and B and COM indirectly" do
      d = objects.find { |o| o.name == "D" }
      d.should_not be_nil
      if !d.nil?
        c = d.directly_orbits
        c.name.should eq("C") if !c.nil?
        indirect_orbits = d.indirect_orbits.map { |i| i.name }
        indirect_orbits.should contain("B")
        indirect_orbits.should contain("COM")
      end
    end

    it "creates object L which orbits K directly and J, E, D, C, B and COM indirectly" do
      l = objects.find { |o| o.name == "L" }
      l.should_not be_nil
      if !l.nil?
        k = l.directly_orbits
        k.name.should eq("K") if !k.nil?
        indirect_orbits = l.indirect_orbits.map { |i| i.name }
        indirect_orbits.should contain("J")
        indirect_orbits.should contain("E")
        indirect_orbits.should contain("D")
        indirect_orbits.should contain("C")
        indirect_orbits.should contain("B")
        indirect_orbits.should contain("COM")
      end
    end

    it "creates COM which orbits nothing" do
      com = objects.find { |o| o.name == "COM" }
      com.should_not be_nil
      com.should be_a(COMObject)
      if !com.nil?
        com.directly_orbits.should be_nil
        com.indirect_orbits.size.should eq(0)
      end
    end

    it "creates a check sum" do
      orbit_map.check_sum.should eq(42)
    end
  end

  describe "finding paths" do
    it "should find the distance between two objects" do
      orbit_map = OrbitMap.new(map2)
      orbit_map.distance_between("YOU", "SAN").should eq(4)
    end
  end
end