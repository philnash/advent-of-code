require "levenshtein"

class FabricBox
  getter id

  @letter_map : Hash(String, Int32)

  def initialize(@id : String)
    @letter_map = @id.split("").reduce(Hash(String, Int32).new(default_value: 0)) do |acc, letter|
      acc[letter] = acc[letter] + 1
      acc
    end
  end

  def has_exactly?(letters : Int32) : Bool
    @letter_map.values.any? { |count| count == letters }
  end
end

class FabricBoxCollection
  getter boxes
  @boxes : Array(FabricBox)

  def initialize(ids : Array(String))
    @boxes = ids.map { |id| FabricBox.new(id) }
  end

  def checksum
    @boxes.count { |box| box.has_exactly? 2 } * @boxes.count { |box| box.has_exactly? 3 }
  end

  def find_close_id
    @boxes.each do |box_i|
      @boxes.each do |box_j|
        if Levenshtein.distance(box_i.id, box_j.id) == 1
          characters_i = box_i.id.split("")
          characters_j = box_j.id.split("")
          char_pairs = characters_i.zip(characters_j)
          return char_pairs.reduce("") do |acc, (char_i, char_j)|
            acc += char_i if char_i == char_j
            acc
          end
        end
      end
    end
  end
end