class ByrValidator
  def self.validate(value : String)
    year = value.to_i
    year <= 2002 && year >= 1920
  end
end

class IyrValidator
  def self.validate(value : String)
    year = value.to_i
    year <= 2020 && year >= 2010
  end
end

class EyrValidator
  def self.validate(value : String)
    year = value.to_i
    year <= 2030 && year >= 2020
  end
end

class HgtValidator
  def self.validate(value : String)
    if value.ends_with?("in")
      height = value[0...-2].to_i
      return height <= 76 && height >= 59
    elsif value.ends_with?("cm")
      height = value[0...-2].to_i
      return height <= 193 && height >= 150
    else
      false
    end
  end
end

class HclValidator
  def self.validate(value : String)
    value.match(/^#[a-f0-9]{6}$/)
  end
end

class EclValidator
  def self.validate(value : String)
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].includes?(value)
  end
end

class PidValidator
  def self.validate(value : String)
    value.size == 9 && value.match(/^\d{9}$/)
  end
end

VALIDATORS = {
  "byr" => ByrValidator,
  "iyr" => IyrValidator,
  "eyr" => EyrValidator,
  "hgt" => HgtValidator,
  "hcl" => HclValidator,
  "ecl" => EclValidator,
  "pid" => PidValidator,
}

module PassportValidator
  REQUIRED_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].sort

  def self.valid_passports(input, validate_data = false)
    passports_data = input.split("\n\n")
    results = passports_data.map do |passport_data|
      validate_passport(passport_data, validate_data)
    end.count(true)
  end

  def self.validate_passport(passport_data, validate_data)
    fields = passport_data.split(/[\s\n]/)
    return false if fields.size < 7
    passport = fields.reduce(Array(String).new) do |passport, field|
      key, value = field.split(":")
      if key != "cid"
        return false if validate_data && !VALIDATORS[key].validate(value)
        passport << key
      end
      passport
    end
    passport.sort == REQUIRED_FIELDS
  end
end
