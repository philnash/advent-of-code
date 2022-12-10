import { loadData, sum } from "../utils.js";

export async function day9() {
  const data = await loadData(9);
  const moves = parse(data);
  return `
    --- Day 9: Rope Bridge ---
    Tail positions for short rope: ${moveRope(moves)}
    Tail positions for long rope: ${moveRope(moves, 10)}
    `;
}

/**
 *
 * @param {string} data
 */
export function parse(data) {
  return data.split("\n").map((line) => {
    const moves = line.split(" ");
    return { dir: moves[0], distance: parseInt(moves[1], 10) };
  });
}

/**
 *
 * @param {{
    dir: string;
    distance: number;
  }[]} moves
 */
export function moveRope(moves, length = 2) {
  const tailPositions = new Set();
  const knots = new Array(length);
  for (let i = 0; i < knots.length; i++) {
    knots[i] = { x: 0, y: 0 };
  }
  tailPositions.add(`${knots.at(-1).x},${knots.at(-1).y}`);
  moves.forEach(({ dir, distance }) => {
    for (let i = 0; i < distance; i++) {
      if (dir === "R") {
        knots[0] = { x: knots[0].x + 1, y: knots[0].y };
      }
      if (dir === "L") {
        knots[0] = { x: knots[0].x - 1, y: knots[0].y };
      }
      if (dir === "U") {
        knots[0] = { x: knots[0].x, y: knots[0].y + 1 };
      }
      if (dir === "D") {
        knots[0] = { x: knots[0].x, y: knots[0].y - 1 };
      }
      for (let knot = 1; knot < knots.length; knot++) {
        knots[knot] = reconcileTail(knots[knot - 1], knots[knot]);
      }
      tailPositions.add(`${knots.at(-1).x},${knots.at(-1).y}`);
    }
  });
  return tailPositions.size;
}

/**
 *
 * @param {{ x: number, y: number }} head
 * @param {{ x: number, y: number }} tail
 */
export function reconcileTail(head, tail) {
  if (
    (head.x === tail.x && head.y === tail.y) ||
    (head.y === tail.y && (head.x === tail.x + 1 || head.x === tail.x - 1)) ||
    (head.x === tail.x && (head.y === tail.y + 1 || head.y === tail.y - 1)) ||
    (head.x === tail.x - 1 &&
      (head.y === tail.y - 1 || head.y === tail.y + 1)) ||
    (head.x === tail.x + 1 &&
      (head.y === tail.y - 1 || head.y === tail.y + 1)) ||
    (head.y === tail.y - 1 &&
      (head.x === tail.x - 1 || head.x === tail.x + 1)) ||
    (head.y === tail.y + 1 && (head.x === tail.x - 1 || head.x === tail.x + 1))
  ) {
    return { ...tail };
  }
  let x = tail.x,
    y = tail.y;
  if (head.x > tail.x) {
    x = tail.x + 1;
  }
  if (head.x < tail.x) {
    x = tail.x - 1;
  }
  if (head.y > tail.y) {
    y = tail.y + 1;
  }
  if (head.y < tail.y) {
    y = tail.y - 1;
  }
  return { x, y };
}
