class SatelliteRegexes
  tester : String

  def initialize(input : String, @part = 1)
    rules = Hash(String, Array(Array((String))) | String).new
    input.split("\n").each do |line|
      rule_number, rule = line.split(": ")
      if rule.starts_with?("\"")
        rules[rule_number] = rule.gsub("\"", "")
      else
        rules[rule_number] = rule.split(" | ").map { |str| str.split(" ") }
      end
    end
    @tester = "^#{replace(rules["0"], rules, part)}$"
    puts @tester
  end

  def replace(rule_group : Array(Array(String)), rules, part = 1)
    "(" + rule_group.map { |rule|
      replace(rule, rules, part)
    }.join("|") + ")"
  end

  def replace(rule_group : Array(String), rules, part = 1)
    if part == 1
      rule_group.map { |str| replace(rules[str], rules) }.join("")
    else
      "(" + rule_group.map { |str|
        case str
        when "8"
          "#{replace(rules["42"], rules, part)}+"
        when "11"
          "(?<rule11>#{replace(rules["42"], rules, part)}(?&rule11)?#{replace(rules["31"], rules, part)})"
        else
          replace(rules[str], rules)
        end
      }.join("") + ")"
    end
  end

  def replace(rule_group : String, rules, part = 1)
    rule_group
  end

  def test(str : String)
    Regex.new(@tester).matches?(str)
  end
end
