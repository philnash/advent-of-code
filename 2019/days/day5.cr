enum Mode
  Position
  Immediate
end

module Instruction
  class Base
    def get_input(instruction, parameter, pointer, memory)
      mode = instruction_to_parameter_mode(instruction, parameter)
      case mode
      when Mode::Position
        return memory[memory[pointer+parameter+1]]
      when Mode::Immediate
        return memory[pointer+parameter+1]
      else
        raise "Impossible parameter mode #{mode}"
      end
    end

    def put_output(instruction, parameter, pointer, memory, value)
      mode = instruction_to_parameter_mode(instruction, parameter)
      case mode
      when Mode::Position
        return memory[memory[pointer+parameter+1]] = value
      when Mode::Immediate
        return memory[pointer+parameter+1] = value
      else
        raise "Impossible parameter mode #{mode}"
      end
    end

    def instruction_to_parameter_mode(instruction, parameter)
      parameter_modes = instruction // 100
      parameter.times { parameter_modes = parameter_modes // 10 }
      return Mode.new(parameter_modes % 10)
    end
  end

  class Add < Base
    def run(pointer, memory)
      memory = memory.dup
      instruction = memory[pointer]
      input1 = get_input(instruction, 0, pointer, memory)
      input2 = get_input(instruction, 1, pointer, memory)
      put_output(instruction, 2, pointer, memory, (input1 + input2))
      return {pointer + 4, memory}
    end
  end

  class Multiply < Base
    def run(pointer, memory)
      memory = memory.dup
      instruction = memory[pointer]
      input1 = get_input(instruction, 0, pointer, memory)
      input2 = get_input(instruction, 1, pointer, memory)
      put_output(instruction, 2, pointer, memory, (input1 * input2))
      return {pointer + 4, memory}
    end
  end

  class Input < Base
    def run(input, pointer, memory)
      return {pointer + 2, memory} if input.nil?
      memory = memory.dup
      instruction = memory[pointer]
      put_output(instruction, 0, pointer, memory, input)
      return {pointer + 2, memory}
    end
  end

  class Output < Base
    def run(pointer, memory, output)
      output = output.dup
      instruction = memory[pointer]
      output_position = memory[pointer+1]
      output.push(memory[output_position])
      return {pointer+2, memory, output}
    end
  end
end

class Intcode5
  getter memory : Array(Int32)
  getter output : Array(Int32)
  @input : Int32 | Nil
  
  def initialize(@program : String, @input = nil)
    @memory = @program.split(',').map { |s| s.to_i }
    @output = [] of Int32
  end

  def initialize_memory(noun = 0, verb = 0)
    @memory = @program.split(',').map { |s| s.to_i }
    @memory[1] = noun
    @memory[2] = verb
    self
  end

  def run
    pointer = 0
    opcode = instruction_to_opcode(@memory[pointer])
    while opcode != 99
      case opcode
      when 1
        pointer, @memory = Instruction::Add.new.run(pointer, @memory)
      when 2
        pointer, @memory = Instruction::Multiply.new.run(pointer, @memory)
      when 3
        pointer, @memory = Instruction::Input.new.run(@input, pointer, @memory)
      when 4
        pointer, @memory, @output = Instruction::Output.new.run(pointer, @memory, @output)
      else
        raise "Incorrect opcode"
      end
      opcode = instruction_to_opcode(@memory[pointer])
    end
    self
  end

  def to_s
    @memory.join(",")
  end

  def instruction_to_opcode(instruction)
    opcode = instruction % 100
  end
end