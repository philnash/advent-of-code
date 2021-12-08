class SegmentSearch
  def self.unique_output_segment_count(input : Array(String))
    input.reduce(0) do |segments, signals|
      input_segments, output_segments = signals.split(" | ")
      segments += output_segments.split(" ").count { |segment| [2, 3, 4, 7].includes?(segment.size) }
    end
  end

  def self.sum_outputs(input : Array(String))
    input.map { |segments| SegmentSearch.new(segments).calculate_numbers }.sum
  end

  @input_segments : Array(Set(String))
  @output_segments : Array(Set(String))

  def initialize(signals : String)
    @input_segments, @output_segments = signals.split(" | ").map { |str| str.split(" ").map { |str| Set.new(str.split("")) } }
  end

  def calculate_numbers
    segments = @input_segments.dup
    result = [
      nil,
      segments.find { |s| s.size == 2 },
      nil,
      nil,
      segments.find { |s| s.size == 4 },
      nil,
      nil,
      segments.find { |s| s.size == 3 },
      segments.find { |s| s.size == 7 },
      nil,
    ]
    segments.delete(result[1])
    four = segments.delete(result[4])
    seven = segments.delete(result[7])
    segments.delete(result[8])
    if four && seven
      result[9] = segments.find { |s| s.size == 6 && seven.subset_of?(s) && four.subset_of?(s) }
      segments.delete(result[9])
      result[0] = segments.find { |s| s.size == 6 && seven.subset_of?(s) }
      segments.delete(result[0])
      result[6] = segments.find { |s| s.size == 6 }
      six = segments.delete(result[6])
      result[3] = segments.find { |s| s.size == 5 && seven.subset_of?(s) }
      three = segments.delete(result[3])
      result[5] = segments.find { |s| six && s.subset_of?(six) }
      segments.delete(result[5])
      result[2] = segments.delete_at(0)
    end
    @output_segments.map { |segment| result.index(segment) }.join("").to_i
  end
end
