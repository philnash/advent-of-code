class Console
  def initialize
  end

  def process_instructions(instructions : Array(String))
    instruction_memory = Set(Int32).new
    accumulator = 0
    pointer = 0
    instructions = instructions.map { |i| parse_instruction(i) }
    while !instruction_memory.includes?(pointer) && pointer < instructions.size
      instruction_memory.add(pointer)
      operation, argument = instructions[pointer]
      case operation
      when "nop"
        pointer += 1
      when "jmp"
        pointer += argument
      else
        accumulator += argument
        pointer += 1
      end
      operation, argument = instructions[pointer] unless pointer >= instructions.size
    end
    return {accumulator, pointer >= instructions.size}
  end

  def find_incorrect_instruction(instructions : Array(String))
    acc, correct = process_instructions(instructions)
    counter = 0
    while !correct
      test_instructions = instructions.dup
      if test_instructions[counter].starts_with?("nop")
        test_instructions[counter] = test_instructions[counter].gsub("nop", "jmp")
        acc, correct = process_instructions(test_instructions)
      elsif test_instructions[counter].starts_with?("jmp")
        test_instructions[counter] = test_instructions[counter].gsub("jmp", "nop")
        acc, correct = process_instructions(test_instructions)
      end
      counter += 1
    end
    acc
  end

  private def parse_instruction(instruction) : {String, Int32}
    match_data = instruction.match(/^(nop|acc|jmp) ([+-]\d+)$/)
    if match_data
      return {match_data[1], match_data[2].to_i}
    else
      raise "EWRONGINSTRUCTION"
    end
  end
end
