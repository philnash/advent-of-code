class Device
  getter frequency : Int32
  getter duplicate : Int32 | Nil

  def initialize
    @frequency = 0
    @duplicate = nil
    @frequencies = Set{@frequency}
  end

  def update(input : Array(String))
    @frequency = input.map { |string| string.to_i }.reduce(@frequency) do |acc, i|
      frequency = acc + i
      @duplicate = frequency if @frequencies.includes?(frequency) && @duplicate.nil?
      @frequencies.add(frequency)
      frequency
    end
  end

  def find_duplicate(input : Array(String))
    while @duplicate.nil?
      update(input)
    end
  end
end
