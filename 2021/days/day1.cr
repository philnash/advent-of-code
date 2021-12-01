class SonarSweep
  def initialize(@depths : Array(Int32))
  end

  def count_increases
    increases = 0
    @depths.each_cons_pair do |a, b|
      increases += 1 if b > a
    end
    increases
  end

  def count_window_increases
    increases = 0
    prev_group_sum = nil
    @depths.each_cons(3, true) do |cons|
      group_sum = cons.sum
      if prev_group_sum
        increases += 1 if group_sum > prev_group_sum
      end
      prev_group_sum = group_sum
    end
    increases
  end
end
