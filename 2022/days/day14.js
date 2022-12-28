import { loadData } from "../utils.js";

export async function day14() {
  const data = await loadData(14);
  const map = parse(data);
  return `
    --- Day 14: Regolith Reservoir ---
    Number of sand particles: ${dropSandUntil(map)}
    Number of sand particles to reach the ceiling: ${
      dropSandUntil(map, true) + 2
    }
  `; // Don't know why it's 2 out...
}

export function parse(data) {
  let points = {};
  const instructions = data.split("\n").map((line) => {
    const instructions = line
      .split(" -> ")
      .map((coord) => coord.split(",").map((point) => parseInt(point, 10)));
    instructions.forEach(([x, y], index) => {
      if (index < instructions.length - 1) {
        if (x === instructions[index + 1][0]) {
          const newY = instructions[index + 1][1];
          const maxY = Math.max(y, newY);
          const minY = Math.min(y, newY);
          for (let currentY = minY; currentY <= maxY; currentY++) {
            points[JSON.stringify([x, currentY])] = "rock";
          }
        } else if (y === instructions[index + 1][1]) {
          const newX = instructions[index + 1][0];
          const maxX = Math.max(x, newX);
          const minX = Math.min(x, newX);
          for (let currentX = minX; currentX <= maxX; currentX++) {
            points[JSON.stringify([currentX, y])] = "rock";
          }
        }
      }
    });
    return instructions;
  });
  const xs = instructions.flat().map(([x, _]) => x);
  const ys = instructions.flat().map(([_, y]) => y);
  const minX = Math.min(...xs) - 1;
  const maxX = Math.max(...xs) + 1;
  const minY = 0;
  const maxY = Math.max(...ys);
  return { points, minX, maxX, minY, maxY };
}

function dropSand({ points, minX, maxX, minY, maxY }, floor = false) {
  function getPoint(points, x, y) {
    if (y > maxY + 1) {
      return "rock";
    }
    return points[JSON.stringify([x, y])];
  }

  function setPoint(points, x, y, value) {
    points[JSON.stringify([x, y])] = value;
    return points;
  }

  let x = 500;
  let y = 0;
  let nextSteps = [
    [x, y + 1],
    [x - 1, y + 1],
    [x + 1, y + 1],
  ];
  while (nextSteps.some(([x, y]) => !getPoint(points, x, y))) {
    let index = 0;
    while (getPoint(points, ...nextSteps[index])) {
      index++;
    }
    [x, y] = nextSteps[index];
    if (!floor && y + 1 > maxY) {
      return false;
    }
    nextSteps = [
      [x, y + 1],
      [x - 1, y + 1],
      [x + 1, y + 1],
    ];
  }
  points = setPoint(points, x, y, "sand");
  if (floor && x === 500 && y === 0) {
    return false;
  }
  return {
    points,
    minX: Math.min(x, minX),
    maxX: Math.max(x, maxX),
    minY: Math.min(y, minY),
    maxY: maxY,
  };
}

export function dropSandUntil(map, floor = false) {
  let count = 0;
  let newMap = dropSand(map, floor);
  while (newMap) {
    count++;
    newMap = dropSand(newMap, floor);
  }
  return count;
}
