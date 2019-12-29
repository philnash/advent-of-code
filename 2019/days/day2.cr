class Intcode2
  getter memory : Array(Int32)
  def initialize(@program : String)
    @memory = @program.split(',').map { |s| s.to_i }
  end

  def initialize_memory(noun = 0, verb = 0)
    @memory = @program.split(',').map { |s| s.to_i }
    @memory[1] = noun
    @memory[2] = verb
    self
  end

  def run
    pointer = 0
    opcode = @memory[pointer]
    while opcode != 99
      input_position1 = @memory[pointer+1]
      input_position2 = @memory[pointer+2]
      output_position = @memory[pointer+3]
      input1 = @memory[input_position1]
      input2 = @memory[input_position2]
      if opcode == 1
        output = input1 + input2
      elsif opcode == 2
        output = input1 * input2
      else
        raise "Incorrect opcode"
      end
      @memory[output_position] = output
      pointer += 4
      opcode = @memory[pointer]
    end
    self
  end

  def to_s
    @memory.join(",")
  end
end

def noun_and_verb_for_result(computer, result)
  noun = 0
  verb = 0
  solved = false
  while noun < 100
    while verb < 100
      computer.initialize_memory(noun, verb)
      solved = computer.run.memory.first == result
      break if solved
      verb += 1
    end
    break if solved
    verb = 0
    noun += 1
  end
  return "#{noun}#{verb}"
end