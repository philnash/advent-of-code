class School
  @fish : Array(Int64)

  def initialize(input : String)
    @fish = input.split(",").map(&.to_i).reduce(Array(Int64).new(9) { 0_i64 }) do |acc, fish|
      acc[fish] += 1
      acc
    end
  end

  def add_day
    new_fish = @fish.shift
    @fish.push(new_fish)
    @fish[6] = @fish[6] + new_fish
  end

  def add_days(days : Int32)
    days.times { self.add_day }
    @fish.sum
  end
end
