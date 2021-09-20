use lazy_static::lazy_static;
use regex::Regex;

const REQUIRED_FIELDS: [&str; 7] = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"];
const EYE_COLORS: [&str; 7] = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];

pub fn validate_passports(input: &str, validate_data: bool) -> u32 {
  let passports: Vec<&str> = input.split("\n\n").collect();
  let mut valid_passports: u32 = 0;
  for passport in passports {
    if valid_passport(passport, validate_data) {
      valid_passports += 1;
    }
  }
  valid_passports
}

fn valid_passport(passport: &str, validate_data: bool) -> bool {
  let pieces: Vec<&str> = passport.split_ascii_whitespace().collect();
  let mut result: Vec<&str> = Vec::new();
  for piece in pieces {
    let mut key_and_value = piece.split(":").collect::<Vec<&str>>();
    let key = key_and_value.remove(0);
    let value = key_and_value.remove(0);
    if REQUIRED_FIELDS.contains(&key) {
      if validate_data {
        let data_valid = match key {
          "cid" => true,
          "byr" => valid_byr(value),
          "iyr" => valid_iyr(value),
          "eyr" => valid_eyr(value),
          "hgt" => valid_hgt(value),
          "hcl" => valid_hcl(value),
          "ecl" => valid_ecl(value),
          "pid" => valid_pid(value),
          _ => false,
        };
        // println!("{} - {}", value, data_valid);
        if data_valid {
          result.push(&key);
        }
      } else {
        result.push(&key);
      }
    }
  }
  // println!("result: {}", result.len());
  result.len() == 7
}

fn valid_byr(value: &str) -> bool {
  match value.parse::<u32>() {
    Ok(number) => return number > 1919 && number < 2003,
    Err(_) => return false,
  }
}

fn valid_iyr(value: &str) -> bool {
  match value.parse::<u32>() {
    Ok(number) => return number >= 2010 && number <= 2020,
    Err(_) => return false,
  }
}

fn valid_eyr(value: &str) -> bool {
  match value.parse::<u32>() {
    Ok(number) => return number >= 2020 && number <= 2030,
    Err(_) => return false,
  }
}

fn valid_hgt(value: &str) -> bool {
  if value.ends_with("in") {
    let number_string: String = value.chars().take_while(|c| c.is_digit(10)).collect();
    let number_result = number_string.parse::<u32>();
    match number_result {
      Ok(number) => number <= 76 && number >= 59,
      Err(_) => false,
    }
  } else if value.ends_with("cm") {
    let number_string: String = value.chars().take_while(|c| c.is_digit(10)).collect();
    let number_result = number_string.parse::<u32>();
    match number_result {
      Ok(number) => number <= 193 && number >= 150,
      Err(_) => false,
    }
  } else {
    false
  }
}

fn valid_hcl(value: &str) -> bool {
  lazy_static! {
    static ref RE: Regex = Regex::new(r"^#[a-fA-F0-9]{6}$").unwrap();
  }
  RE.is_match(value)
}

fn valid_ecl(value: &str) -> bool {
  EYE_COLORS.contains(&value)
}

fn valid_pid(value: &str) -> bool {
  lazy_static! {
    static ref RE: Regex = Regex::new(r"^\d{9}$").unwrap();
  }
  RE.is_match(value)
}
