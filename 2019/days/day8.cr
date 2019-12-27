class SIF
  def self.decode(input, width, height)
    new(input.split("").map { |c| c.to_i }.in_groups_of(width*height), width, height)
  end

  getter layers : Array(Array(Int32 | Nil))
  def initialize(@layers, @width : Int32, @height : Int32)
  end

  def checksum
    _, layer = @layers.reduce({Int32::MAX, layers[0]}) do |memo, layer|
      zeroes = layer.count { |d| d == 0 }
      memo[0] > zeroes ? { zeroes, layer } : memo
    end
    layer.count { |d| d == 1 } * layer.count { |d| d == 2 }
  end

  def image
    image = @layers.reduce(@layers.first) do |memo, layer|
      layer.map_with_index do |pixel, i|
        memo[i] = memo[i] == 0 || memo[i] == 1 ? memo[i] : pixel
      end
      memo
    end
    image.in_groups_of(@width)
  end

  def print_image
    image.each { |row| puts row.map { |pixel| pixel == 2 || pixel == 0 ? " " : pixel }.join("") }
  end
end