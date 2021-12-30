module Packets
  abstract class Base
    property version : Int32
    property type_id : Int32

    def initialize(@version, @type_id)
    end

    abstract def version_total
    abstract def value
  end

  class Literal < Base
    property value : Int64

    def initialize(@version, @type_id, @value)
      super(@version, @type_id)
    end

    def version_total
      @version
    end
  end

  class Operator < Base
    property sub_packets : Array(Packets::Base)

    def initialize(@version, @type_id, @sub_packets)
      super(@version, @type_id)
    end

    def version_total
      @version + sub_packets.map(&.version_total).sum
    end

    def value
      case type_id
      when 0
        sub_packets.map(&.value).sum
      when 1
        sub_packets.map(&.value).product
      when 2
        sub_packets.map(&.value).min
      when 3
        sub_packets.map(&.value).max
      when 5
        sub_packets[0].value > sub_packets[1].value ? 1_i64 : 0_i64
      when 6
        sub_packets[0].value < sub_packets[1].value ? 1_i64 : 0_i64
      when 7
        sub_packets[0].value == sub_packets[1].value ? 1_i64 : 0_i64
      else
        0_i64
      end
    end
  end

  MAPPING = {
    "0" => "0000",
    "1" => "0001",
    "2" => "0010",
    "3" => "0011",
    "4" => "0100",
    "5" => "0101",
    "6" => "0110",
    "7" => "0111",
    "8" => "1000",
    "9" => "1001",
    "A" => "1010",
    "B" => "1011",
    "C" => "1100",
    "D" => "1101",
    "E" => "1110",
    "F" => "1111",
  }

  def self.parse(input : String)
    binary = parse_hex(input)
    parse_binary(binary)
  end

  def self.parse_binary(binary : String)
    pointer = 0
    packets = [] of Base
    while pointer < binary.size
      begin
        headers = parse_headers(binary[pointer...(pointer + 6)])
        pointer += 6
        if headers[:type_id] == 4
          number = binary[(pointer + 1)..(pointer + 4)]
          while binary[pointer] != '0'
            pointer += 5
            number += binary[(pointer + 1)..(pointer + 4)]
          end
          pointer += 5
          packets.push(Literal.new(headers[:version], headers[:type_id], number.to_i64(2)))
        else
          length_type_id = binary[pointer]
          pointer += 1
          if length_type_id == '0'
            total_length = binary[pointer...pointer + 15].to_i(2)
            pointer = pointer += 15
            sub_packets = parse_binary(binary[pointer...pointer + total_length])
            packets.push(Operator.new(headers[:version], headers[:type_id], sub_packets))
            pointer += total_length
          else
            total_sub_packets = binary[pointer...pointer + 11].to_i(2)
            pointer += 11
            next_packets = parse_binary(binary[pointer..-1])
            pointer = binary.size
            packets.push(Operator.new(headers[:version], headers[:type_id], next_packets.shift(total_sub_packets)))
            packets = packets + next_packets
          end
        end
      rescue ex
        return packets
      end
    end
    packets
  end

  def self.parse_hex(input : String)
    input.split("").map { |c| MAPPING[c] }.join("")
  end

  def self.parse_headers(input : String)
    version = input[0..2].to_i(2)
    type_id = input[3..5].to_i(2)
    return {version: version, type_id: type_id}
  end

  def self.version_total(packets : Array(Base))
    packets.map(&.version_total).sum
  end
end
