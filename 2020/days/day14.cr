# mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
# mem[8] = 11
# mem[7] = 101
# mem[8] = 0

module DockingProgram
  abstract class Program
    @memory : Hash(String, UInt64)

    def initialize
      @memory = Hash(String, UInt64).new
    end

    def sum
      @memory.values.sum
    end

    def self.run_program(input : Array(String))
      program = new
      mask = ""
      input.each do |line|
        if line.starts_with?("mask")
          mask = line.gsub(/mask = /, "")
        else
          match_data = line.match(/^mem\[(?<address>\d+)\] = (?<value>\d+)$/)
          program.write(match_data["address"], match_data["value"], mask) if match_data
        end
      end
      program.sum
    end
  end

  class V1 < Program
    def write(address : String, value : String, mask : String)
      new_value = UInt64.new(value).to_s(2).rjust(36, '0').split("")
      mask.split("").each_with_index do |bit, index|
        new_value[index] = bit unless bit == "X"
      end
      @memory[address] = new_value.join("").to_u64(2)
    end
  end

  class V2 < Program
    def write(address : String, value : String, mask : String)
      new_values = UInt64.new(value)
      memory_locations = [UInt64.new(address).to_s(2).rjust(36, '0').split("")]
      mask.split("").each_with_index do |bit, index|
        if bit == "1"
          memory_locations.each { |val| val[index] = bit }
        elsif bit == "X"
          new_locations = Array(Array(String)).new
          memory_locations.each do |add|
            new_add = add.dup
            new_add[index] = add[index] == "1" ? "0" : "1"
            new_locations.push(new_add)
            new_locations.push(add)
          end
          memory_locations = new_locations
        end
      end
      memory_locations.each do |add|
        @memory[add.join("")] = new_values
      end
    end
  end
end

puts Int64.new(0b11).to_s(2)
puts "11".to_i(2).to_s(2)

input = ["mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
         "mem[8] = 11",
         "mem[7] = 101",
         "mem[8] = 0"]
input2 = ["mask = 000000000000000000000000000000X1001X",
          "mem[42] = 100",
          "mask = 00000000000000000000000000000000X0XX",
          "mem[26] = 1"]

puts DockingProgram::V1.run_program(input)
puts DockingProgram::V2.run_program(input2)
