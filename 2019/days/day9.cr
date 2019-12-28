module Intcode9
  enum Mode
    Position
    Immediate
    Relative
  end

  module Instruction
    class Base
      def get_input(instruction, parameter, pointer, memory, relative_base)
        mode = instruction_to_parameter_mode(instruction, parameter)
        case mode
        when Mode::Position
          return 0_i64 if memory[pointer + parameter + 1] >= memory.size
          return memory[memory[pointer + parameter + 1]]
        when Mode::Immediate
          return 0_i64 if pointer + parameter + 1 >= memory.size
          return memory[pointer + parameter + 1]
        when Mode::Relative
          return 0_i64 if (memory[pointer + parameter + 1] + relative_base) >= memory.size
          return memory[memory[pointer + parameter + 1] + relative_base]
        else
          raise "Impossible parameter mode #{mode}"
        end
      end

      def put_output(instruction, parameter, pointer, memory, relative_base, value : Int64)
        mode = instruction_to_parameter_mode(instruction, parameter)
        case mode
        when Mode::Position
          memory = resize_memory(memory[pointer + parameter + 1], memory) if memory[pointer + parameter + 1] >= memory.size
          memory[memory[pointer + parameter + 1]] = value
        when Mode::Immediate
          memory = resize_memory(pointer + parameter + 1, memory) if pointer + parameter + 1 >= memory.size
          memory[pointer + parameter + 1] = value
        when Mode::Relative
          memory = resize_memory(memory[pointer + parameter + 1] + relative_base, memory) if memory[pointer + parameter + 1] + relative_base >= memory.size
          memory[memory[pointer + parameter + 1] + relative_base] = value
        else
          raise "Impossible parameter mode #{mode}"
        end
        return memory
      end

      def instruction_to_parameter_mode(instruction, parameter)
        parameter_modes = instruction // 100
        parameter.times { parameter_modes = parameter_modes // 10 }
        return Mode.new((parameter_modes % 10).to_i32)
      end

      def resize_memory(index, memory)
        additional_size = index - memory.size
        additional_array = Array.new(additional_size + 1, 0_i64)
        return memory + additional_array
      end
    end

    class Add < Base
      def run(pointer, memory, relative_base)
        memory = memory.dup
        instruction = memory[pointer]
        input1 = get_input(instruction, 0, pointer, memory, relative_base)
        input2 = get_input(instruction, 1, pointer, memory, relative_base)
        memory = put_output(instruction, 2, pointer, memory, relative_base, (input1 + input2))
        return {pointer + 4, memory}
      end
    end

    class Multiply < Base
      def run(pointer, memory, relative_base)
        memory = memory.dup
        instruction = memory[pointer]
        input1 = get_input(instruction, 0, pointer, memory, relative_base)
        input2 = get_input(instruction, 1, pointer, memory, relative_base)
        memory = put_output(instruction, 2, pointer, memory, relative_base, (input1 * input2))
        return {pointer + 4, memory}
      end
    end

    class Input < Base
      def run(input : Int64, pointer, memory, relative_base)
        return {pointer + 2, memory} if input.nil?
        memory = memory.dup
        instruction = memory[pointer]
        memory = put_output(instruction, 0, pointer, memory, relative_base, input)
        return {pointer + 2, memory}
      end
    end

    class Output < Base
      def run(pointer, memory, output, relative_base)
        output = output.dup
        memory = memory.dup
        instruction = memory[pointer]
        result = get_input(instruction, 0, pointer, memory, relative_base)
        output.push(result)
        return {pointer + 2, memory, output}
      end
    end

    class JumpIfTrue < Base
      def run(pointer, memory, relative_base)
        instruction = memory[pointer]
        memory = memory.dup
        parameter1 = get_input(instruction, 0, pointer, memory, relative_base)
        parameter2 = get_input(instruction, 1, pointer, memory, relative_base)
        if parameter1 != 0
          pointer = parameter2
        else
          pointer = pointer + 3
        end
        return {pointer, memory}
      end
    end

    class JumpIfFalse < Base
      def run(pointer, memory, relative_base)
        instruction = memory[pointer]
        memory = memory.dup
        parameter1 = get_input(instruction, 0, pointer, memory, relative_base)
        parameter2 = get_input(instruction, 1, pointer, memory, relative_base)
        if parameter1 == 0
          pointer = parameter2
        else
          pointer = pointer + 3
        end
        return {pointer, memory}
      end
    end

    class LessThan < Base
      def run(pointer, memory, relative_base)
        memory = memory.dup
        instruction = memory[pointer]
        parameter1 = get_input(instruction, 0, pointer, memory, relative_base)
        parameter2 = get_input(instruction, 1, pointer, memory, relative_base)
        output = parameter1 < parameter2 ? 1_i64 : 0_i64
        memory = put_output(instruction, 2, pointer, memory, relative_base, output)
        return {pointer + 4, memory}
      end
    end

    class Equal < Base
      def run(pointer, memory, relative_base)
        memory = memory.dup
        instruction = memory[pointer]
        parameter1 = get_input(instruction, 0, pointer, memory, relative_base)
        parameter2 = get_input(instruction, 1, pointer, memory, relative_base)
        output = parameter1 == parameter2 ? 1_i64 : 0_i64
        memory = put_output(instruction, 2, pointer, memory, relative_base, output)
        return {pointer + 4, memory}
      end
    end

    class AdjustRelativeBase < Base
      def run(pointer, memory, relative_base)
        instruction = memory[pointer]
        memory = memory.dup
        parameter = get_input(instruction, 0, pointer, memory, relative_base)
        relative_base = relative_base + parameter
        return {pointer + 2, relative_base, memory}
      end
    end
  end

  class Computer
    getter memory : Array(Int64)
    getter output : Array(Int64)
    getter halted : Bool

    def initialize(@program : String)
      @memory = @program.split(',').map { |s| s.to_i64 }
      @output = [] of Int64
      @halted = false
      @pointer = 0_i64
      @relative_base = 0_i64
    end

    def run(input = [] of Int64)
      opcode = instruction_to_opcode(@memory[@pointer])
      while opcode != 99_i64
        case opcode
        when 1_i64
          @pointer, @memory = Instruction::Add.new.run(@pointer, @memory, @relative_base)
        when 2_i64
          @pointer, @memory = Instruction::Multiply.new.run(@pointer, @memory, @relative_base)
        when 3_i64
          return self if input.empty?
          next_input = input.shift.to_i64
          @pointer, @memory = Instruction::Input.new.run(next_input, @pointer, @memory, @relative_base)
        when 4_i64
          @pointer, @memory, @output = Instruction::Output.new.run(@pointer, @memory, @output, @relative_base)
        when 5_i64
          @pointer, @memory = Instruction::JumpIfTrue.new.run(@pointer, @memory, @relative_base)
        when 6_i64
          @pointer, @memory = Instruction::JumpIfFalse.new.run(@pointer, @memory, @relative_base)
        when 7_i64
          @pointer, @memory = Instruction::LessThan.new.run(@pointer, @memory, @relative_base)
        when 8_i64
          @pointer, @memory = Instruction::Equal.new.run(@pointer, @memory, @relative_base)
        when 9_i64
          @pointer, @relative_base, @memory = Instruction::AdjustRelativeBase.new.run(@pointer, @memory, @relative_base)
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