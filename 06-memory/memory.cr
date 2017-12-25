class Memory
  getter counter : Int32
  getter state : Array(Int32)

  def initialize(@state : Array(Int32))
    @states = Set(Array(Int32)).new
    @states << @state
    @counter = 0
    @finished = false
  end

  def finished?
    @finished
  end

  def reallocate!
    @counter += 1
    state = @state.dup
    highest_value = state.max
    index = state.index { |value| value == highest_value }
    if index
      state[index] = 0
      while highest_value > 0
        index += 1
        state[index.modulo(@state.size)] += 1
        highest_value -= 1
      end
      @finished = true if @states.includes?(state)
      @states << state
      @state = state
    end
    return self
  end

  def self.reallocations_until_optimal(input)
    memory = self.new(input)
    while !memory.finished?
      memory.reallocate!
    end
    memory.counter
  end
end
