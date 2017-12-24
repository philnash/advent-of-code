class Passphrase
  def self.count_valid_phrases(phrases : Array(String))
    phrases.count { |phrase| Passphrase.new(phrase.strip).is_valid? }
  end

  def initialize(@phrase : String)
  end

  def is_valid?
    word_list = @phrase.split(" ")
    word_set = Set.new(word_list)
    return word_list.size == word_set.size
  end
end
