pub struct BoardingPass {
  row: String,
  seat: String,
}

pub fn highest_seat_id(seats: &Vec<String>) -> u32 {
  let mut seat_ids: Vec<u32> = Vec::new();
  for seat in seats {
    let id = BoardingPass::new(seat).seat_id();
    seat_ids.push(id);
  }
  *(seat_ids.iter().max().unwrap())
}

pub fn missing_seat(seats: &Vec<String>) -> u32 {
  let mut seat_ids: Vec<u32> = Vec::new();
  for seat in seats {
    let id = BoardingPass::new(seat).seat_id();
    seat_ids.push(id);
  }
  seat_ids.sort();
  let mut current_id = seat_ids[0];
  for seat in seat_ids.iter().skip(1) {
    if current_id + 1 == *seat {
      current_id += 1;
    } else {
      break;
    }
  }
  current_id + 1
}

impl BoardingPass {
  pub fn new(input: &String) -> BoardingPass {
    let row: String = input.chars().take(7).collect();
    let seat: String = input.chars().skip(7).take(3).collect();

    BoardingPass { row, seat }
  }

  fn row_number(&self) -> u32 {
    self.search(self.row.chars().collect(), 0, 127, 'F')
  }

  fn seat_number(&self) -> u32 {
    self.search(self.seat.chars().collect(), 0, 7, 'L')
  }

  pub fn seat_id(&self) -> u32 {
    self.row_number() * 8 + self.seat_number()
  }

  fn search(&self, input: Vec<char>, mut min: u32, mut max: u32, lower_char: char) -> u32 {
    for choice in input {
      if choice == lower_char {
        max = (max + min) / 2;
      } else {
        min = (max + min) / 2 + 1
      }
    }
    min
  }
}
