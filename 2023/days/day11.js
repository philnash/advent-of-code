import { loadData } from "../utils.js";

export async function day11() {
  const data = await loadData(11);
  const map = parse(data);
  const input = expand(map);

  return `
  --- Day 11: Cosmic Expansion ---
  Sum of the distances between galaxies: ${distanceBetweenGalaxies(input)}
  Sum of the distances between galaxies with bigger gaps: ${distanceBetweenGalaxies(
    newExpand(map),
    1000000
  )}
  `;
}

function parse(input) {
  return input.split("\n").map((line) => line.split(""));
}

function expand(map) {
  let newRows = [];
  for (const row of map) {
    newRows.push([...row]);
    if (row.every((point) => point === ".")) {
      newRows.push([...row]);
    }
  }
  let newMap = new Array(newRows.length).fill(0).map(() => new Array());
  for (let x = 0; x < map[0].length; x++) {
    const col = newRows.map((row) => row[x]);
    for (let y = 0; y < newRows.length; y++) {
      newMap[y].push(newRows[y][x]);
    }
    if (col.every((point) => point === ".")) {
      for (let newRow of newMap) {
        newRow.push(".");
      }
    }
  }
  return newMap;
}

function manhattanDistance(point, other, map, extraDistance = 10) {
  const down = other.y - point.y;
  const along = other.x - point.x;
  let distance = 0;
  if (along > 0) {
    for (let i = point.x; i < other.x; i++) {
      distance += map[point.y][i] === "X" ? extraDistance : 1;
    }
  }
  if (along < 0) {
    for (let i = other.x; i < point.x; i++) {
      distance += map[point.y][i] === "X" ? extraDistance : 1;
    }
  }
  if (down > 0) {
    for (let i = point.y; i < other.y; i++) {
      distance += map[i][point.x] === "X" ? extraDistance : 1;
    }
  }
  if (down < 0) {
    for (let i = other.y; i < point.y; i++) {
      distance += map[i][other.x] === "X" ? extraDistance : 1;
    }
  }
  return distance;
}

function distanceBetweenGalaxies(map, extraDistance = 10) {
  const galaxies = map.flatMap((row, y) =>
    row
      .map((point, x) => {
        if (point === "#") {
          return { x, y };
        }
      })
      .filter((point) => !!point)
  );
  return galaxies.reduce((distance, galaxy, index) => {
    for (let i = index + 1; i < galaxies.length; i++) {
      distance =
        distance + manhattanDistance(galaxy, galaxies[i], map, extraDistance);
    }
    return distance;
  }, 0);
}

function newExpand(map) {
  let newRows = [];
  for (const row of map) {
    if (row.every((point) => point === "." || point === "X")) {
      newRows.push(new Array(row.length).fill("X"));
    } else {
      newRows.push([...row]);
    }
  }
  let newMap = new Array(newRows.length).fill(0).map(() => new Array());
  for (let x = 0; x < map[0].length; x++) {
    const col = newRows.map((row) => row[x]);
    if (col.every((point) => point === "." || point === "X")) {
      for (let newRow of newMap) {
        newRow.push("X");
      }
    } else {
      for (let y = 0; y < newRows.length; y++) {
        newMap[y].push(newRows[y][x]);
      }
    }
  }
  return newMap;
}
