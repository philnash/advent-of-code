pub fn sum_pairs_to_2020(numbers: &Vec<u32>) -> Result<u32, String> {
  for i in 0..numbers.len() {
    for j in (i + 1)..numbers.len() {
      if numbers[i] + numbers[j] == 2020 {
        return Ok(numbers[i] * numbers[j]);
      }
    }
  }
  Err(String::from("No pairs sum to 2020"))
}

pub fn sum_triples_to_2020(numbers: &Vec<u32>) -> Result<u32, String> {
  for i in 0..numbers.len() {
    for j in (i + 1)..numbers.len() {
      for k in (j + 1)..numbers.len() {
        if numbers[i] + numbers[j] + numbers[k] == 2020 {
          return Ok(numbers[i] * numbers[j] * numbers[k]);
        }
      }
    }
  }
  Err(String::from("No pairs sum to 2020"))
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn finds_correct_sum_and_multiplies_for_two() {
    let numbers = vec![1721, 979, 366, 299, 675, 1456];
    assert_eq!(sum_pairs_to_2020(&numbers).unwrap(), 514579);
  }

  #[test]
  fn finds_correct_sum_and_multiplies_for_three() {
    let numbers = vec![1721, 979, 366, 299, 675, 1456];
    assert_eq!(sum_triples_to_2020(&numbers).unwrap(), 241861950);
  }
}
