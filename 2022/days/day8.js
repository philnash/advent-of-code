import { loadData, sum } from "../utils.js";

export async function day8() {
  const data = await loadData(8);
  return `
    --- Day 8: Treetop Tree House ---
    Visible trees: ${countVisibleTrees(data)}
    Highest scenic count: ${findHighestScenicCount(data)}
  `;
}

export function countVisibleTrees(data) {
  const trees = parse(data);
  return trees
    .flatMap((lineTrees, y) =>
      lineTrees.flatMap((tree, x) => isVisible(x, y, trees))
    )
    .filter(Boolean).length;
}

export function findHighestScenicCount(data) {
  const trees = parse(data);
  return Math.max(
    ...trees.flatMap((lineTrees, y) =>
      lineTrees.flatMap(
        (tree, x) =>
          scenicScoreDown(x, y, trees) *
          scenicScoreLeft(x, y, trees) *
          scenicScoreRight(x, y, trees) *
          scenicScoreUp(x, y, trees)
      )
    )
  );
}

export function parse(data) {
  return data
    .split("\n")
    .map((line) => line.split("").map((tree) => parseInt(tree, 10)));
}

export function isVisible(x, y, map) {
  if (x === 0 || y === 0 || x === map[0].length - 1 || y == map.length - 1) {
    return true;
  }
  return (
    isVisibleLeft(x, y, map) ||
    isVisibleRight(x, y, map) ||
    isVisibleUp(x, y, map) ||
    isVisibleDown(x, y, map)
  );
}

export function isVisibleLeft(x, y, map) {
  let pointer = x - 1;
  const height = map[y][x];
  while (pointer >= 0) {
    if (map[y][pointer] >= height) return false;
    pointer--;
  }
  return true;
}

export function isVisibleRight(x, y, map) {
  let pointer = x + 1;
  const height = map[y][x];
  while (pointer < map[y].length) {
    if (map[y][pointer] >= height) return false;
    pointer++;
  }
  return true;
}

export function isVisibleUp(x, y, map) {
  let pointer = y - 1;
  const height = map[y][x];
  while (pointer >= 0) {
    if (map[pointer][x] >= height) return false;
    pointer--;
  }
  return true;
}

export function isVisibleDown(x, y, map) {
  let pointer = y + 1;
  const height = map[y][x];
  while (pointer < map.length) {
    if (map[pointer][x] >= height) return false;
    pointer++;
  }
  return true;
}

export function scenicScoreLeft(x, y, map) {
  let pointer = x - 1;
  if (pointer < 0) return 0;
  const height = map[y][x];
  let count = 0;
  while (pointer >= 0) {
    count++;
    if (map[y][pointer] >= height) return count;
    pointer--;
  }
  return count;
}

export function scenicScoreRight(x, y, map) {
  let pointer = x + 1;
  if (pointer > map[y].length) return 0;
  const height = map[y][x];
  let count = 0;
  while (pointer < map[y].length) {
    count++;
    if (map[y][pointer] >= height) return count;
    pointer++;
  }
  return count;
}

export function scenicScoreUp(x, y, map) {
  let pointer = y - 1;
  if (pointer < 0) return 0;
  const height = map[y][x];
  let count = 0;
  while (pointer >= 0) {
    count++;
    if (map[pointer][x] >= height) return count;
    pointer--;
  }
  return count;
}

export function scenicScoreDown(x, y, map) {
  let pointer = y + 1;
  if (pointer > map.length) return 0;
  const height = map[y][x];
  let count = 0;
  while (pointer < map.length) {
    count++;
    if (map[pointer][x] >= height) return count;
    pointer++;
  }
  return count;
}
