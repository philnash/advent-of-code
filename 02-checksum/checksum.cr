module ChecksumCalculate
  def calculate(spreadsheet)
    spreadsheet.split(/\n/).reject { |row| row.empty? }.map { |row| row_value(row) }.sum
  end
end

module Checksum
  extend ChecksumCalculate

  def self.row_value(row)
    minmax = row.split(/\s+/).map { |char| char.to_i }.minmax
    minmax[1] - minmax[0]
  end
end

module Checksum2
  extend ChecksumCalculate

  def self.row_value(row)
    result = 0
    row.split(/\s+/).map { |char| char.to_i }.each_permutation(2) do |p|
      minmax = p.minmax
      result = minmax[1] / minmax[0] if minmax[1].modulo(minmax[0]) == 0
    end
    return result
  end
end