class Memory
  getter counter : Int32
  getter state : Array(Int32)

  def initialize(@state : Array(Int32))
    @states = Set(Array(Int32)).new
    @states << @state
    @counter = 0
    @finished = false
    @state_counter = Hash(Array(Int32), Int32).new
    @state_counter[@state] = 0
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
      if @states.includes?(state)
        @finished = true
      else
        @state_counter[state] = @counter
      end
      @states << state
      @state = state
    end
    return self
  end

  def reallocation_loop
    return unless finished?
    @counter - @state_counter[@state]
  end

  def reallocate_until_optimal!
    while !finished?
      reallocate!
    end
  end
end
