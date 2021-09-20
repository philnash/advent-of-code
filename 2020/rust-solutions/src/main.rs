mod day1;
mod day2;
mod day3;
mod day4;
mod utils;
use std::path::Path;

fn main() {
    // Day 1
    let path = Path::new("../days/day1.txt");
    let numbers = utils::read_all_ints(path);
    println!(
        "## Day 1 ##\nPart 1: {:?}\nPart 2: {:?}",
        day1::sum_pairs_to_2020(&numbers).unwrap(),
        day1::sum_triples_to_2020(&numbers).unwrap()
    );

    // Day 2
    let path = Path::new("../days/day2.txt");
    let strings = utils::read_string_lines(path);

    println!(
        "## Day 2 ##\nPart 1: {:?}\nPart 2: {:?}",
        day2::check_policies::<day2::TobogganPasswordPolicy>(&strings),
        day2::check_policies::<day2::SledPasswordPolicy>(&strings)
    );

    // Day 3
    let path = Path::new("../days/day3.txt");
    let strings = utils::read_string_lines(path);
    let toboggan_trajectory = day3::TobogganTrajectory::new(strings);
    println!(
        "## Day 3 ##\nPart 1: {:?}\nPart 2: {}",
        toboggan_trajectory.traverse(3, 1),
        toboggan_trajectory.test_paths(vec![(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])
    );

    // Day 4
    let path = Path::new("../days/day4.txt");
    let file_contents = utils::read_file(path);
    let input = file_contents.as_str();
    println!(
        "## Day 4 ##\nPart 1: {:?}\nPart 2: {:?}",
        day4::validate_passports(input, false),
        day4::validate_passports(input, true)
    )
}
