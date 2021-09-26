use std::collections::HashSet;
use std::iter::FromIterator;

pub fn answered_yes_to_any_question(input: &String) -> u32 {
  let groups: Vec<&str> = input.split("\n\n").collect();
  let mut number_of_answers = 0;
  for group in groups {
    let people: Vec<&str> = group.split("\n").collect();
    let mut answers: Vec<char> = Vec::new();
    for person in people {
      let mut chars: Vec<char> = person.chars().collect();
      answers.append(&mut chars);
    }
    answers.sort();
    answers.dedup();
    number_of_answers += answers.len();
  }
  number_of_answers as u32
}

pub fn answered_yes_to_all_questions(input: &String) -> usize {
  input
    .split("\n\n")
    .map(|group| {
      let mut sets = group
        .lines()
        .map(|line| HashSet::<char>::from_iter(line.chars().into_iter()))
        .collect::<Vec<HashSet<char>>>();
      let first_set = sets.remove(0);
      sets
        .into_iter()
        .fold(first_set, |acc, group| &acc & &group)
        .len()
    })
    .sum()
}
