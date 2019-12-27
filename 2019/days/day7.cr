module Intcode7
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
          return memory[memory[pointer + parameter + 1]]
        when Mode::Immediate
          return memory[pointer + parameter + 1]
        else
          raise "Impossible parameter mode #{mode}"
        end
      end

      def put_output(instruction, parameter, pointer, memory, value)
        mode = instruction_to_parameter_mode(instruction, parameter)
        case mode
        when Mode::Position
          return memory[memory[pointer + parameter + 1]] = value
        when Mode::Immediate
          return memory[pointer + parameter + 1] = value
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
        result = get_input(instruction, 0, pointer, memory)
        output.push(result)
        return {pointer + 2, memory, output}
      end
    end

    class JumpIfTrue < Base
      def run(pointer, memory)
        instruction = memory[pointer]
        parameter1 = get_input(instruction, 0, pointer, memory)
        parameter2 = get_input(instruction, 1, pointer, memory)
        if parameter1 != 0
          pointer = parameter2
        else
          pointer = pointer + 3
        end
        return pointer
      end
    end

    class JumpIfFalse < Base
      def run(pointer, memory)
        instruction = memory[pointer]
        parameter1 = get_input(instruction, 0, pointer, memory)
        parameter2 = get_input(instruction, 1, pointer, memory)
        if parameter1 == 0
          pointer = parameter2
        else
          pointer = pointer + 3
        end
        return pointer
      end
    end

    class LessThan < Base
      def run(pointer, memory)
        memory = memory.dup
        instruction = memory[pointer]
        parameter1 = get_input(instruction, 0, pointer, memory)
        parameter2 = get_input(instruction, 1, pointer, memory)
        output = parameter1 < parameter2 ? 1 : 0
        put_output(instruction, 2, pointer, memory, output)
        return {pointer + 4, memory}
      end
    end

    class Equal < Base
      def run(pointer, memory)
        memory = memory.dup
        instruction = memory[pointer]
        parameter1 = get_input(instruction, 0, pointer, memory)
        parameter2 = get_input(instruction, 1, pointer, memory)
        output = parameter1 == parameter2 ? 1 : 0
        put_output(instruction, 2, pointer, memory, output)
        return {pointer + 4, memory}
      end
    end
  end

  class Computer
    getter memory : Array(Int32)
    getter output : Array(Int32)
    getter halted : Bool

    def initialize(@program : String)
      @memory = @program.split(',').map { |s| s.to_i }
      @output = [] of Int32
      @halted = false
      @pointer = 0
    end

    def run(input = [] of Int32)
      opcode = instruction_to_opcode(@memory[@pointer])
      while opcode != 99
        case opcode
        when 1
          @pointer, @memory = Instruction::Add.new.run(@pointer, @memory)
        when 2
          @pointer, @memory = Instruction::Multiply.new.run(@pointer, @memory)
        when 3
          return self if input.empty?
          next_input = input.shift
          @pointer, @memory = Instruction::Input.new.run(next_input, @pointer, @memory)
        when 4
          @pointer, @memory, @output = Instruction::Output.new.run(@pointer, @memory, @output)
        when 5
          @pointer = Instruction::JumpIfTrue.new.run(@pointer, @memory)
        when 6
          @pointer = Instruction::JumpIfFalse.new.run(@pointer, @memory)
        when 7
          @pointer, @memory = Instruction::LessThan.new.run(@pointer, @memory)
        when 8
          @pointer, @memory = Instruction::Equal.new.run(@pointer, @memory)
        else
          raise "Incorrect opcode #{opcode}"
        end
        opcode = instruction_to_opcode(@memory[@pointer])
      end
      @halted = true
      self
    end

    def to_s
      @memory.join(",")
    end

    def instruction_to_opcode(instruction)
      opcode = instruction % 100
    end
  end
end

class AmplifierGroup
  def signal_permutations(offset = 0)
    options = (0 + offset...@count + offset).to_a
    options.permutations
  end

  def initialize(@count : Int32)
  end

  def find_max_output(program)
    signal_permutations.reduce({0, [] of Array(Int32)}) do |memo, permutation|
      current_amp = 0
      last_output = 0
      while current_amp < @count
        computer = Intcode7::Computer.new(program)
        output = computer.run([permutation[current_amp], last_output]).output
        last_output = output.first
        current_amp += 1
      end
      if last_output > memo[0]
        memo = {last_output, permutation}
      end
      memo
    end
  end

  def find_max_output_for_feedback_loop(program)
    signal_permutations(5).reduce({0, [] of Array(Int32)}) do |memo, permutation|
      last_output = max_output_for_permutation_in_feedback_loop(program, permutation)
      if last_output > memo[0]
        memo = {last_output, permutation}
      end
      memo
    end
  end

  def max_output_for_permutation_in_feedback_loop(program, permutation)
    amps = (0...@count).to_a.map { Intcode7::Computer.new(program) }
    last_output = 0
    amps.each_with_index do |amp, i|
      output = amp.run([permutation[i], last_output]).output
      last_output = output.last
    end
    while !amps.last.halted
      amps.select { |a| !a.halted }.each do |amp|
        output = amp.run([last_output]).output
        last_output = output.last
      end
    end
    return last_output
  end
end