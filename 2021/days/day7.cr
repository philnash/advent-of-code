module CrabSubmarines
  class Base
    @crabs : Array(Int32)

    def initialize(input : String)
      @crabs = input.split(",").map(&.to_i)
    end
  end

  class ConstantFuelCost < Base
    def optimum_position
      crabs = @crabs.sort
      size = crabs.size
      (crabs[(size - 1) // 2] + crabs[size // 2]) // 2
    end

    def fuel
      position = self.optimum_position
      @crabs.map { |crab| (crab - position).abs }.sum
    end
  end

  class IncreasingFuelCost < Base
    def optimum_position
      (@crabs.sum/@crabs.size)
    end

    def fuel
      position = self.optimum_position
      [position.ceil, position.floor].map do |pos|
        @crabs.map do |crab|
          steps = (crab - pos).abs
          (steps * (steps + 1)) // 2
        end.sum
      end.min.to_i
    end
  end
end
