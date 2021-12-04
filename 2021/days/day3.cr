class PowerConsumption
  def initialize(@diagnostics : Array(String))
  end

  def rates
    cols = @diagnostics.first.size
    gamma = ""
    epsilon = ""
    cols.times do |col|
      digits = column_counts(@diagnostics, col)
      if digits["0"] > digits["1"]
        gamma += "0"
        epsilon += "1"
      else
        gamma += "1"
        epsilon += "0"
      end
    end
    gamma.to_i(2) * epsilon.to_i(2)
  end

  def oxygen(diagnostics = @diagnostics, col = 0)
    if diagnostics.size == 1
      return diagnostics.first.to_i(2)
    else
      digits = column_counts(diagnostics, col)
      if digits["0"] > digits["1"]
        return oxygen(diagnostics.select { |d| d[col] == '0' }, col + 1)
      else
        return oxygen(diagnostics.select { |d| d[col] == '1' }, col + 1)
      end
    end
  end

  def co2(diagnostics = @diagnostics, col = 0)
    if diagnostics.size == 1
      return diagnostics.first.to_i(2)
    else
      digits = column_counts(diagnostics, col)
      if digits["0"] > digits["1"]
        return co2(diagnostics.select { |d| d[col] == '1' }, col + 1)
      else
        return co2(diagnostics.select { |d| d[col] == '0' }, col + 1)
      end
    end
  end

  def life_support_rating
    oxygen * co2
  end

  private def column_counts(diagnostics, col)
    {"0" => 0, "1" => 0}.merge(diagnostics.map do |diagnostic|
      diagnostic.split("")[col]
    end.tally)
  end
end
