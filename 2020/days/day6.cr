class FamilyGroup
  def self.any_yes(input : String)
    input.split("\n\n").map { |group| FamilyGroup.new(group.split("\n")).any_yeses }.sum
  end

  def self.every_yes(input : String)
    input.split("\n\n").map { |group| FamilyGroup.new(group.split("\n")).all_yeses }.sum
  end

  def initialize(@input : Array(String))
  end

  def any_yeses
    @input.map { |line| line.split("") }.flatten.uniq.size
  end

  def all_yeses
    sets = @input.map { |line| Set.new(line.split("")) }
    first = sets.shift
    sets.reduce(first) { |acc, next_set| acc & next_set }.size
  end
end
