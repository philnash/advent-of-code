class Polymer
  @template : Array(String)
  @rules : Hash({String, String}, String)

  def initialize(input : String)
    template, rule_input = input.split("\n\n")
    @template = template.split("")
    @rules = Hash({String, String}, String).new
    rule_input.split("\n").each do |line|
      pair, insertion = line.split(" -> ")
      pair = pair.split("")
      rule = {pair[0], pair[1]}
      @rules[rule] = insertion
    end
  end

  def step(count : Int32)
    blank_rules = Hash({String, String}, Int64).new
    @rules.keys.each do |k|
      blank_rules[k] = 0
    end
    counts = blank_rules.dup
    @template.each_cons_pair do |a, b|
      counts[{a, b}] += 1
    end
    count.times do
      new_counts = blank_rules.dup
      counts.each do |pair, v|
        old_pair_count = counts[pair]
        new_char = @rules[pair]
        new_counts[{pair[0], new_char}] += old_pair_count
        new_counts[{new_char, pair[1]}] += old_pair_count
      end
      counts = new_counts
    end
    letter_count = Hash(String, Int64).new
    # All the letters are the first letter of a pair, except the last one.
    letter_count[@template.last] = 1
    counts.each do |(a, b), v|
      if letter_count[a]?
        letter_count[a] += v
      else
        letter_count[a] = v
      end
    end
    minmax = letter_count.minmax_of { |k, v| v }
    minmax[1] - minmax[0]
  end
end
