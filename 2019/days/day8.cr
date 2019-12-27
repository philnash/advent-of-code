class SIF
  def self.decode(input, width, height)
    new(input.split("").map { |c| c.to_i }.in_groups_of(width*height))
  end

  getter layers : Array(Array(Int32 | Nil))
  def initialize(@layers)
  end

  def checksum
    _, layer = @layers.reduce({Int32::MAX, layers[0]}) do |memo, layer|
      zeroes = layer.count { |d| d == 0 }
      memo[0] > zeroes ? { zeroes, layer } : memo
    end
    layer.count { |d| d == 1 } * layer.count { |d| d == 2 }
  end
end
