class FamilyGroup
  def self.any_yes(input : String)
    create_groups(input).map(&.any_yeses).sum
  end

  def self.every_yes(input : String)
    create_groups(input).map(&.all_yeses).sum
  end

  private def self.create_groups(input : String)
    input.split("\n\n").map do |group|
      FamilyGroup.new(group.split("\n").map { |line| line.split("") })
    end
  end

  def initialize(@input : Array(Array(String)))
  end

  def any_yeses
    @input.flatten.uniq.size
  end

  def all_yeses
    answer_sets = @input.map { |line| Set.new(line) }
    answer_sets.reduce(answer_sets.first) { |acc, next_set| acc & next_set }.size
  end
end
