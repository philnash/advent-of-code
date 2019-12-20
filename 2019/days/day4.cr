module Password
  def self.count_passwords(string_range)
    range_boundaries = string_range.split("-").map { |num| num.to_i }
    passwords = (range_boundaries[0]..range_boundaries[1]).reduce(Set(Int32).new) do |memo, password|
      memo.add password if digits_never_decrease?(password) && has_double_digits?(password)
      memo
    end
    return passwords.size
  end

  def self.count_passwords_2(string_range)
    range_boundaries = string_range.split("-").map { |num| num.to_i }
    passwords = (range_boundaries[0]..range_boundaries[1]).reduce(Set(Int32).new) do |memo, password|
      memo.add password if digits_never_decrease?(password) && has_double_digits?(password) && has_exactly_double_digits?(password)
      memo
    end
    return passwords.size
  end

  def self.digits_never_decrease?(password)
    split_digits(password).each_cons(2) { |cons| return false if cons[1] < cons[0] }
    true
  end

  def self.has_double_digits?(password)
    split_digits(password).each_cons(2) { |cons| return true if cons[0] == cons[1] }
    false
  end

  def self.has_exactly_double_digits?(password)
    password_string = password.to_s
    password_string.scan(/(11|22|33|44|55|66|77|88|99)/).map do |match|
      digit = match[0][0].to_s
      !(password_string =~ Regex.new(digit*3))
    end.any?
  end

  def self.split_digits(password)
    password.to_s.split("").map { |digit| digit.to_i }
  end
end