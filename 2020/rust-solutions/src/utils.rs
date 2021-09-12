use std::path::Path;
use std::num::ParseIntError;

pub fn read_all_ints(file_name: &Path) -> Vec<u32> {
  let results: Vec<Result<u32, ParseIntError>> = std::fs::read_to_string(file_name)
      .expect("file not found!")
      .lines()
      .map(|x| x.parse::<u32>())
      .collect();
  let result: Result<Vec<u32>, ParseIntError> = results.into_iter().collect();
  result.unwrap()
}