class Offsets
  getter pointer : Int32
  getter list : Array(Int32)
  getter counter : Int32

  def initialize(@input : String)
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
    @list[prev_pointer] += 1
    return self
  end

  def self.jumps_until_out(input : String)
    offsets = self.new(input)
    while !offsets.finished?
      offsets.jump!
    end
    offsets.counter
  end
end
