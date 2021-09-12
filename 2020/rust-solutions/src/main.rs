mod day1;
mod day2;
mod utils;
use std::path::Path;

fn main() {
    let path = Path::new("../days/day1.txt");
    let numbers = utils::read_all_ints(path);
    println!(
        "## Day 1 ##\nPart 1: {:?}\nPart 2: {:?}",
        day1::sum_pairs_to_2020(&numbers).unwrap(),
        day1::sum_triples_to_2020(&numbers).unwrap()
    );

    let path = Path::new("../days/day2.txt");
    let strings = utils::read_string_lines(path);

    println!(
        "## Day 2 ##\nPart 1: {:?}\nPart 2: {:?}",
        day2::check_policies::<day2::TobogganPasswordPolicy>(&strings),
        day2::check_policies::<day2::SledPasswordPolicy>(&strings)
    )
}
