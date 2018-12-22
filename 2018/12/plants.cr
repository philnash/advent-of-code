class Plants
  def self.parse(text)
    plant_match = text.match(/^initial state: ([#\.]+)/)
    rule_lines = text.split("\n\n")[1].split("\n")
    if plant_match && rule_lines
      index = 0_i64
      plants = plant_match[1].split("")
      Plants.new(plants, rule_lines)
    end
  end

  getter plants : Hash(Int64, String)
  getter rules : Hash(String, String)

  def initialize(plants, rules)
    index = 0_i64
    @plants = plants.reduce(Hash(Int64, String).new(".")) do |acc, plant|
      acc[index] = plant
      index += 1
      acc
    end
    @rules = rules.reduce(Hash(String, String).new(".")) do |acc, string|
      string = string.split(/ => /)
      acc[string[0]] = string[1]
      acc
    end
  end

  def state
    @plants.keys.sort.map { |i| @plants[i] }.join("").gsub(/^\.+/, "").gsub(/\.+$/, "")
  end

  def tick(times=1)
    prev_state = self.state
    prev_count = self.count
    times.times do |time|
      last_plants = @plants.dup
      index = last_plants.keys.min - 5
      while index < last_plants.keys.max + 5
        group = [last_plants.fetch(index-2, "."), last_plants.fetch(index-1, "."), last_plants.fetch(index, "."), last_plants.fetch(index+1, "."), last_plants.fetch(index+2,".")]
        new_plant = @rules[group.join("")]
        if (new_plant == "." && @plants.has_key?(index)) || new_plant == "#"
          @plants[index] = new_plant
        end
        index += 1
      end
      if self.state == prev_state
        further_iterations = times - time - 1
        @plants.keys.sort.each do |k|
          v = @plants.delete(k)
          if v
            @plants[k+further_iterations] = v
          end
        end
        break
      else
        prev_state = self.state
        prev_count = self.count
      end
    end
  end

  def count
    @plants.select { |i, p| p == "#" }.keys.sum
  end
end