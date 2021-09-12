use std::num::ParseIntError;
use std::path::Path;

pub fn read_all_ints(file_name: &Path) -> Vec<u32> {
  let results: Vec<Result<u32, ParseIntError>> = std::fs::read_to_string(file_name)
    .expect("file not found!")
    .lines()
    .map(|x| x.parse::<u32>())
    .collect();
  let result: Result<Vec<u32>, ParseIntError> = results.into_iter().collect();
  result.unwrap()
}

pub fn read_string_lines(file_name: &Path) -> Vec<String> {
  std::fs::read_to_string(file_name)
    .expect("file not found!")
    .lines()
    .map(|s| String::from(s))
    .collect::<Vec<String>>()
}
