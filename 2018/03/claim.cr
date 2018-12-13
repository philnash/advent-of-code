class Claim
  getter id : Int32
  getter left : Int32
  getter top : Int32
  getter width : Int32
  getter height : Int32
  getter square_inches : Array(SquareInch)

  def self.parse(instruction : String)
    match = instruction.match(/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/)
    if match
      return new(match[1].to_i, match[2].to_i, match[3].to_i, match[4].to_i, match[5].to_i)
    else
      puts instruction
      nil
    end
  end

  def initialize(@id, @left, @top, @width, @height)
    @square_inches = [] of SquareInch
    @height.times do |row|
      @width.times do |col|
        @square_inches.push(SquareInch.new(@left + col, @top + row))
      end
    end
  end

  def includes?(square_inch)
    square_inches.includes?(square_inch)
  end

  def ==(other)
    return id == other.id
  end
end

class SquareInch
  getter x : Int32
  getter y : Int32

  def initialize(@x, @y)
  end

  def ==(other)
    return x == other.x && y == other.y
  end

  def_hash @x, @y
end

class ClaimCollection
  getter claims : Array(Claim)

  def initialize
    @claims = [] of Claim
  end

  def add(claim)
    @claims.push(claim)
  end

  def duplicate_square_inches
    all_square_inches = claims.flat_map { |c| c.square_inches }
    seen = Set.new([] of SquareInch)
    duplicates = Set.new([] of SquareInch)
    all_square_inches.each do |square_inch|
      duplicates.add(square_inch) if seen.includes?(square_inch)
      seen.add(square_inch)
    end
    return duplicates
  end

  def intact_claims
    dsi = duplicate_square_inches
    return claims.reduce(Set.new([] of Claim)) do |acc, claim|
      acc.add(claim) unless Set.new(claim.square_inches).intersects?(dsi)
      acc
    end
  end
end