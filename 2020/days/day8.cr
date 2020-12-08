class Console
  def self.find_incorrect_instruction(instructions : Array(String))
    console = Console.new
    acc, correct = console.process_instructions(instructions)
    counter = 0
    while !correct
      test_instructions = instructions.dup
      if test_instructions[counter].starts_with?("nop")
        test_instructions[counter] = test_instructions[counter].gsub("nop", "jmp")
        acc, correct = console.process_instructions(test_instructions)
      elsif test_instructions[counter].starts_with?("jmp")
        test_instructions[counter] = test_instructions[counter].gsub("jmp", "nop")
        acc, correct = console.process_instructions(test_instructions)
      end
      counter += 1
    end
    acc
  end

  def initialize
  end

  def process_instructions(instructions : Array(String))
    instruction_memory = Set({Int32, String}).new
    accumulator = 0
    pointer = 0
    instructions = instructions.map_with_index { |instruction, index| {index, instruction} }
    index, instruction = instructions[pointer]
    while !instruction_memory.includes?({index, instruction}) && pointer < instructions.size
      instruction_memory.add({index, instruction})
      operation, argument = parse_instruction(instruction)
      case operation
      when "nop"
        pointer += 1
      when "jmp"
        pointer += argument
      else
        accumulator += argument
        pointer += 1
      end
      index, instruction = instructions[pointer] unless pointer >= instructions.size
    end
    return {accumulator, pointer >= instructions.size}
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
