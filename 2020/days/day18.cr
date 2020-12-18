module WrongMaths
  class V1
    def self.calculate(expression : String)
      elements = expression.split("").reject { |s| s == " " }
      calculate_from_array(elements)
    end

    private def self.calculate_from_array(elements : Array(String))
      result = nil
      while elements.size > 0
        next_element = elements.shift
        if next_element == "("
          sub_expression = Array(String).new
          brackets = 1
          while brackets > 0
            next_element = elements.shift
            if next_element.match(/[\d+*]/)
              sub_expression.push(next_element)
            elsif next_element == "("
              brackets += 1
              sub_expression.push(next_element)
            elsif next_element == ")"
              brackets -= 1
              sub_expression.push(next_element) unless brackets == 0
            end
          end
          if result.nil?
            result = calculate_from_array(sub_expression)
          else
            rhs = calculate_from_array(sub_expression)
          end
        elsif next_element.match(/\d/)
          if result.nil?
            result = next_element.to_i64
          else
            rhs = next_element.to_i64
          end
        elsif next_element == "+" || next_element == "*"
          operator = next_element
        end
        if rhs.is_a?(Int64) && operator.is_a?(String)
          if result.nil?
            result = operator == "+" ? 0 : 1
          end
          result = operator == "+" ? result.as(Int64) + rhs : result.as(Int64) * rhs
          rhs = nil
          operator = nil
        end
      end
      result
    end
  end

  class V2
    def self.calculate(expression : String)
      elements = expression.split("").reject { |s| s == " " }
      calculate_from_array(elements)
    end

    private def self.calculate_from_array(elements : Array(String))
      result = nil
      while elements.size > 0
        next_element = elements.shift
        if next_element == "("
          sub_expression = Array(String).new
          brackets = 1
          while brackets > 0
            next_element = elements.shift
            if next_element.match(/[\d+*]/)
              sub_expression.push(next_element)
            elsif next_element == "("
              brackets += 1
              sub_expression.push(next_element)
            elsif next_element == ")"
              brackets -= 1
              sub_expression.push(next_element) unless brackets == 0
            end
          end
          if result.nil?
            result = calculate_from_array(sub_expression)
          else
            rhs = calculate_from_array(sub_expression)
          end
        elsif next_element.match(/\d/)
          if result.nil?
            result = next_element.to_i64
          else
            rhs = next_element.to_i64
          end
        elsif next_element == "+" || next_element == "*"
          operator = next_element
          if operator == "*"
            rhs = calculate_from_array(elements)
          end
        end
        if rhs.is_a?(Int64) && operator.is_a?(String)
          if result.nil?
            result = operator == "+" ? 0 : 1
          end
          result = operator == "+" ? result.as(Int64) + rhs : result.as(Int64) * rhs
          rhs = nil
          operator = nil
        end
      end
      result
    end
  end
end
