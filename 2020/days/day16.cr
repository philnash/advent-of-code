class Ticket
  def self.parse_rules(input : String)
    input.split("\n\n").first.split("\n").reduce(Hash(String, Array(Range(Int32, Int32))).new) do |acc, line|
      match_data = line.match(/^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/)
      if match_data
        acc[match_data[1]] = [match_data[2].to_i..match_data[3].to_i, match_data[4].to_i..match_data[5].to_i]
      end
      acc
    end
  end

  def self.parse_my_ticket(input : String)
    input.split("\n\n")[1].split("\n")[1].split(",").map { |s| s.to_i64 }
  end

  def self.parse_nearby_tickets(input : String, rules)
    input.split("\n\n")[2].split("\n").skip(1).map { |line|
      line.split(",").map { |s| s.to_i }
    }.map { |numbers| Ticket.new(rules, numbers) }
  end

  def self.invalid_tickets_sum(tickets : Array(Ticket))
    tickets.map { |t| t.invalid_number }.reject(Nil).sum
  end

  def self.labels(tickets, rules)
    valid = tickets.reject { |ticket| !ticket.invalid_number.nil? }
    results = Hash(String, Int32).new
    while rules.size > 0
      possibilities = valid.map { |ticket|
        ticket.numbers.map { |number|
          ticket.possible_label(number, rules)
        }
      }
      index = 0

      while index < possibilities.first.size
        labels = possibilities.map { |possibility| possibility[index] }.reduce { |acc, labels| acc & labels }
        if labels.size == 1
          results[labels.first] = index
          rules.delete(labels.first)
        end
        index += 1
      end
    end
    results
  end

  def self.departure_product(ticket, labels)
    labels.select { |k, v| k.starts_with?("departure") }.map { |k, v| ticket[v] }.product
  end

  @ranges : Array(Range(Int32, Int32))
  getter numbers : Array(Int32)

  def initialize(@rules : Hash(String, Array(Range(Int32, Int32))), @numbers : Array(Int32))
    @ranges = @rules.values.flatten
  end

  def invalid_number
    @numbers.map do |number|
      number unless @ranges.any? do |rule|
                      rule.includes?(number)
                    end
    end.reject(Nil).first?
  end

  def possible_label(number, rules)
    remaining_rules = rules.compact_map do |label, ranges|
      label if ranges.any? { |range| range.includes?(number) }
    end
    remaining_rules
  end
end
