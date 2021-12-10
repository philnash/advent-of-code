class SyntaxChecker
  OPEN_CHARS  = ["(", "{", "<", "["]
  CLOSE_CHARS = [")", "}", ">", "]"]
  CHAR_POINTS = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137,
  }
  COMPLETE_CHAR_POINTS = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }

  def self.score_errors(input : Array(String))
    input.map { |line| self.find_error(line) }.compact.map { |char| CHAR_POINTS[char] }.sum
  end

  def self.score_completions(input : Array(String))
    scores = input.reject { |line|
      self.find_error(line)
    }.map { |line|
      self.complete(line)
    }.compact.map { |completion|
      self.score_complete(completion)
    }
    scores.sort[scores.size // 2]
  end

  def self.find_error(line : String)
    chars = line.split("")
    chars.reduce([] of String) do |memo, char|
      if OPEN_CHARS.includes?(char)
        memo.push(char)
      elsif CLOSE_CHARS.includes?(char)
        if OPEN_CHARS.index(memo.last) == CLOSE_CHARS.index(char)
          memo.pop
        else
          return char
        end
      end
      memo
    end
    return nil
  end

  def self.complete(line : String)
    chars = line.split("")
    remaining_open_chars = chars.reduce([] of String) do |memo, char|
      if OPEN_CHARS.includes?(char)
        memo.push(char)
      elsif CLOSE_CHARS.includes?(char)
        if OPEN_CHARS.index(memo.last) == CLOSE_CHARS.index(char)
          memo.pop
        else
          break
        end
      end
      memo
    end
    if remaining_open_chars
      remaining_open_chars.map do |char|
        char_index = OPEN_CHARS.index(char)
        if char_index
          CLOSE_CHARS[char_index]
        end
      end.reverse
    end
  end

  def self.score_complete(chars : Array(String | Nil))
    chars.reduce(0_u64) do |score, char|
      score * 5 + COMPLETE_CHAR_POINTS[char]
    end
  end
end
