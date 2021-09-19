pub struct TobogganTrajectory {
  width: usize,
  height: usize,
  map: Vec<Vec<String>>,
}

impl TobogganTrajectory {
  pub fn new(lines: Vec<String>) -> TobogganTrajectory {
    let height = lines.len();
    let mut map: Vec<Vec<String>> = Vec::<Vec<String>>::new();
    for line in 0..lines.len() {
      map.push(lines[line].chars().map(|s| String::from(s)).collect());
    }

    let width = map[0].len();
    TobogganTrajectory { width, height, map }
  }

  fn tree(&self, x: usize, y: usize) -> bool {
    self.map[y][x % self.width] == "#"
  }

  pub fn traverse(&self, right: usize, down: usize) -> u64 {
    let mut x = right;
    let mut y = down;
    let mut trees: u64 = 0;
    while y < self.height {
      if self.tree(x, y) {
        trees += 1;
      }
      x = x + right;
      y = y + down;
    }
    trees
  }

  pub fn test_paths(&self, paths: Vec<(usize, usize)>) -> u64 {
    let mut product: u64 = 1;
    for (right, down) in paths {
      product = product * self.traverse(right, down);
    }
    product
  }
}
