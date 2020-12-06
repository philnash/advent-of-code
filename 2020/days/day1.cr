class Expenses
  def initialize(@input : Array(Int32))
  end

  def sum_to_2020(count = 2)
    @input.combinations(count).each do |items|
      break items if items.sum == 2020
    end || [] of Int32
  end

  def multiple(count = 2)
    sum_to_2020(count).product
  end
end
