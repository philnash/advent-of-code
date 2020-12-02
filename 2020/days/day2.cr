class Passwords
  def self.check(input, policy_class)
    input.map do |line|
      match_data = line.match(/^(?<min>\d+)-(?<max>\d+) (?<char>[a-z]): (?<password>[a-z]+)$/)
      return false unless match_data
      policy = policy_class.new(match_data["min"].to_i, match_data["max"].to_i, match_data["char"].char_at(0))
      policy.valid?(match_data["password"])
    end.select { |result| result }.size
  end
end

abstract class Policy
  getter min : Int32
  getter max : Int32
  getter char : Char

  def initialize(@min, @max, @char)
  end

  abstract def valid?(password : String)
end

class SledPolicy < Policy
  def valid?(password)
    count = password.chars.select { |char| char == @char }.size
    count >= @min && count <= @max
  end
end

class TobogganPolicy < Policy
  def valid?(password)
    [password[@min - 1] == @char, password[@max - 1] == @char].one?
  end
end
