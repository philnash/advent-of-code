class JoltAdapters
  def initialize(@adapters : Array(Int32))
    @adapters << @adapters.max + 3
  end

  def differences
    @adapters.sort.reduce({0, Array(Int32).new}) do |acc, adapter|
      acc[1] << (adapter - acc[0])
      {adapter, acc[1]}
    end[1]
  end

  def difference_multiple
    differences.select { |d| d == 1 }.size * differences.select { |d| d == 3 }.size
  end

  def all_connections
    # If there are 2 connectors with a difference of 1 in a row, the number of connections doubles
    # If there are 3, the number of connections multiplies by 4
    # If there are 4, the number of connections multiplies by 7
    # And so on.
    #
    # This is calculated by moving through the differences, and counting how
    # many there are in a row, adding up a streak by adding one less than the
    # current count of differences in a row.
    differences.reduce({:total => 1_i64, :streak => 1, :count => 1}) do |acc, current_diff|
      if current_diff === 3
        acc[:total] = acc[:total]*acc[:streak]
        acc[:streak] = acc[:count] = 1
      else
        acc[:streak] += acc[:count] - 1
        acc[:count] += 1
      end
      acc
    end[:total]
  end
end
