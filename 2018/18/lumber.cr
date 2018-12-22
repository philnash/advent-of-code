struct Acre
  enum Fill
    Open
    Trees
    Lumberyard
  end

  getter fill : Acre::Fill

  def initialize(char : String)
    @fill = case char
            when "."
              Fill::Open
            when "|"
              Fill::Trees
            else
              Fill::Lumberyard
            end
  end

  def to_s
    case fill
    when .open?
      "."
    when .trees?
      "|"
    else
      "#"
    end
  end
end

class LandscapeCache
  def initialize()
    @hash = Hash(String, Tuple(Landscape,Int32)).new
  end

  def add(prev_land : Landscape, next_land : Landscape, position : Int32)
    @hash[prev_land.to_s] = {next_land, position}
  end

  def present?(landscape : Landscape)
    @hash.has_key?(landscape.to_s)
  end

  def [](landscape : Landscape)
    @hash[landscape.to_s]
  end
end

struct Landscape
  def self.parse(text)
    acres = text.split(/\n/).map do |line|
      line.split("").map do |char|
        Acre.new(char)
      end
    end
    new(acres)
  end

  getter acres : Array(Array(Acre))
  getter width : Int32
  getter height : Int32

  def initialize(@acres, @cache = LandscapeCache.new)
    @width = @acres[0].size
    @height = @acres.size
  end

  def [](col, row)
    @acres[row][col]
  end

  def tick(times=1)
    count = 0
    landscape = self
    while count < times
      if @cache.present?(landscape)
        landscape, position = @cache[landscape]
        cycle = count - position
        while count < (times - cycle)
          count += cycle
        end
      else
        new_acres = landscape.acres.map_with_index do |row, row_index|
          row.map_with_index do |acre, col_index|
            other_acres = landscape.surrounding(col_index, row_index)
            case acre.fill
            when .open?
              other_acres.count(&.fill.trees?) >= 3 ? Acre.new("|") : acre.dup
            when .trees?
              other_acres.count(&.fill.lumberyard?) >= 3 ? Acre.new("#") : acre.dup
            else
              other_acres.any?(&.fill.lumberyard?) && other_acres.any?(&.fill.trees?) ? acre.dup : Acre.new(".")
            end
          end
        end
        prev_land = landscape
        landscape = Landscape.new(new_acres, @cache)
        @cache.add(prev_land, landscape, count)
      end
      count = count + 1
    end
    landscape
  end

  def surrounding(col, row)
    coords = (col - 1..col + 1).map do |c|
      (row - 1..row + 1).compact_map do |r|
        {c, r} unless r < 0 || r >= height || c < 0 || c >= width || (r == row && c == col)
      end
    end.reduce([] of Acre) do |acc, row|
      row.each { |(c, r)| acc << self[c,r] }
      acc
    end
  end

  def draw
    @acres.map { |row| row.map(&.to_s).join("") }.join("\n")
  end

  def to_s
    @acres.map { |row| row.map(&.to_s).join("") }.join("")
  end

  def total
    flat_acres = @acres.flatten
    flat_acres.sum { |acre| acre.fill.trees? ? 1 : 0 } * flat_acres.sum { |acre| acre.fill.lumberyard? ? 1 : 0 }
  end
end