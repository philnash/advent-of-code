use lazy_static::lazy_static;
use regex::Regex;
use unicode_segmentation::UnicodeSegmentation;

pub fn check_policies<T: Policy>(lines: &Vec<String>) -> u32 {
  let mut correct_passwords = 0;
  for line in lines {
    let shop = T::new(line.to_string());
    if shop.valid() {
      correct_passwords += 1;
    }
  }
  correct_passwords
}

fn get_fields_from_input(input: &str) -> Option<(&str, &str, usize, usize)> {
  lazy_static! {
    static ref RE: Regex =
      Regex::new(r"^(?P<min>\d+)-(?P<max>\d+) (?P<c>[a-z]): (?P<p>[a-z]+)$").unwrap();
  }
  match RE.captures(input) {
    Some(capture) => {
      let password = capture.name("p").unwrap().as_str();
      let char = capture.name("c").unwrap().as_str();
      let min = capture
        .name("min")
        .unwrap()
        .as_str()
        .parse::<usize>()
        .unwrap();
      let max = capture
        .name("max")
        .unwrap()
        .as_str()
        .parse::<usize>()
        .unwrap();
      return Some((password, char, min, max));
    }
    None => return None,
  }
}

pub trait Policy {
  fn new(input: String) -> Self;
  fn valid(&self) -> bool;
}

pub struct TobogganPasswordPolicy {
  input: String,
}

impl Policy for TobogganPasswordPolicy {
  fn new(input: String) -> TobogganPasswordPolicy {
    TobogganPasswordPolicy { input }
  }
  fn valid(&self) -> bool {
    let (password, char, min, max) = get_fields_from_input(&self.input).unwrap();
    let count = password.matches(char).count();
    return count <= max && count >= min;
  }
}

pub struct SledPasswordPolicy {
  input: String,
}

impl Policy for SledPasswordPolicy {
  fn new(input: String) -> SledPasswordPolicy {
    SledPasswordPolicy { input }
  }
  fn valid(&self) -> bool {
    let (password, char, min, max) = get_fields_from_input(&self.input).unwrap();
    let graphemes = UnicodeSegmentation::graphemes(password, true).collect::<Vec<&str>>();
    return (graphemes[min - 1] == char || graphemes[max - 1] == char)
      && !(graphemes[min - 1] == char && graphemes[max - 1] == char);
  }
}
