class Register
  getter max_historical_value : Int32

  def initialize
    @registers = Hash(String, Int32).new(0)
    @max_historical_value = 0
  end

  def process_instructions(input)
    input.split("\n").each { |instruction| process_instruction(instruction) }
  end

  def process_instruction(instruction)
    target_register, target_op, target_value, _if, if_register, if_op, if_value = instruction.split
    if_register_value = @registers[if_register]
    if_value = if_value.to_i
    should_process = case if_op
                     when "<"  then if_register_value < if_value
                     when "<=" then if_register_value <= if_value
                     when ">"  then if_register_value > if_value
                     when ">=" then if_register_value >= if_value
                     when "==" then if_register_value == if_value
                     when "!=" then if_register_value != if_value
                     end
    if should_process
      multiple = target_op == "inc" ? 1 : -1
      target_value = target_value.to_i
      @registers[target_register] = @registers[target_register] + target_value * multiple
    end
    @max_historical_value = [@max_historical_value, max_register].max unless @registers.empty?
  end

  def max_register
    @registers.values.max
  end

  def [](register_name)
    @registers[register_name]
  end
end
