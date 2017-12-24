class Offsets
  getter pointer : Int32
  getter list : Array(Int32)
  getter counter : Int32

  def initialize(@input : String, @previous_pointer_updater : PointerUpdater = RegularPointerUpdater.new)
    @list = @input.strip.split("\n").map { |word| word.to_i }
    @pointer = 0
    @finished = false
    @counter = 0
  end

  def finished?
    @finished
  end

  def jump!
    @counter += 1
    prev_pointer = @pointer
    @pointer = @pointer + @list[@pointer]
    @finished = true if @pointer >= @list.size || @pointer < 0
    @list[prev_pointer] = @previous_pointer_updater.update(@list[prev_pointer])
    return self
  end

  def self.jumps_until_out(input : String, previous_pointer_updater : PointerUpdater = RegularPointerUpdater.new)
    offsets = self.new(input, previous_pointer_updater)
    while !offsets.finished?
      offsets.jump!
    end
    offsets.counter
  end
end

abstract class PointerUpdater
  abstract def update(value)
end

class RegularPointerUpdater < PointerUpdater
  def update(value)
    value + 1
  end
end

class SometimesDecreasingPointerUpdater < PointerUpdater
  def update(value)
    value >= 3 ? value - 1 : value + 1
  end
end
