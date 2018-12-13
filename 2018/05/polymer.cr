class Polymer
  def self.react(units : String)
    react(units.split("")).join("")
  end

  def self.react(units : Array(String))
    i = 0
    while i < units.size - 1
      if units[i] != units[i+1] && units[i].upcase == units[i+1].upcase
        units.delete_at(i, 2)
        i = i-1
      else
        i += 1
      end
    end
    units
  end

  def self.find_best(units : String)
    Set.new(units.split("").map(&.upcase)).map do |unit|
      react(units.gsub(unit, "").gsub(unit.downcase, ""))
    end.min_by(&.size)
  end
end
