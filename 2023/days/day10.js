import { loadData } from "../utils.js";

export async function day10() {
  const data = await loadData(10);
  const map = parse(data);
  const [x, y] = findStart(map);
  const loop = findLoop(map, [x, y]);
  console.log(Array.from(loop).length);
  return `
  --- Day 10: Pipe Maze ---
  Furthest from start: ${Array.from(loop).length / 2}
  Enclosed tiles: ${enclosed(loop, map)}
  `;
}

function parse(input) {
  return input.split("\n").map((line) => line.split(""));
}

function findStart(map) {
  for (let i = 0; i < map.length; i++) {
    for (let j = 0; j < map[i].length; j++) {
      if (map[i][j] === "S") {
        return [j, i];
      }
    }
  }
}

function firstMove(map, [startX, startY]) {
  const startingMoves = [
    { x: startX - 1, y: startY, dir: "W" },
    { x: startX + 1, y: startY, dir: "E" },
    { x: startX, y: startY - 1, dir: "N" },
    { x: startX, y: startY + 1, dir: "S" },
  ]
    .filter(
      ({ x, y }) => x >= 0 && x < map[0].length && y >= 0 && y < map.length
    )
    .filter(({ x, y }) => map[y][x] !== ".")
    .filter(({ x, y }) => {
      const next = map[y][x];
      if (x === startX) {
        return (
          next === "|" ||
          (y > startY && (next === "J" || next === "L")) ||
          (y < startY && (next === "F" || next === "7"))
        );
      } else {
        return (
          next === "-" ||
          (x > startX && (next === "J" || next === "7")) ||
          (x < startX && (next === "F" || next === "L"))
        );
      }
    });
  return startingMoves[0];
}

function findLoop(map, [startX, startY]) {
  const currentSquare = firstMove(map, [startX, startY]);
  const squares = new Set([`${currentSquare.x},${currentSquare.y}`]);
  while (!(currentSquare.x === startX && currentSquare.y === startY)) {
    const currentPipe = map[currentSquare.y][currentSquare.x];
    if (currentPipe === "-") {
      currentSquare.x =
        currentSquare.dir === "E" ? currentSquare.x + 1 : currentSquare.x - 1;
    } else if (currentPipe === "|") {
      currentSquare.y =
        currentSquare.dir === "N" ? currentSquare.y - 1 : currentSquare.y + 1;
    } else if (currentPipe === "F") {
      if (currentSquare.dir === "N") {
        currentSquare.x = currentSquare.x + 1;
        currentSquare.dir = "E";
      } else {
        currentSquare.y = currentSquare.y + 1;
        currentSquare.dir = "S";
      }
    } else if (currentPipe === "7") {
      if (currentSquare.dir === "N") {
        currentSquare.x = currentSquare.x - 1;
        currentSquare.dir = "W";
      } else {
        currentSquare.y = currentSquare.y + 1;
        currentSquare.dir = "S";
      }
    } else if (currentPipe === "J") {
      if (currentSquare.dir === "S") {
        currentSquare.x = currentSquare.x - 1;
        currentSquare.dir = "W";
      } else {
        currentSquare.y = currentSquare.y - 1;
        currentSquare.dir = "N";
      }
    } else if (currentPipe === "L") {
      if (currentSquare.dir === "S") {
        currentSquare.x = currentSquare.x + 1;
        currentSquare.dir = "E";
      } else {
        currentSquare.y = currentSquare.y - 1;
        currentSquare.dir = "N";
      }
    }
    squares.add(`${currentSquare.x},${currentSquare.y}`);
  }
  return squares;
}

function enclosed(loop, map) {
  let insideTiles = 0;
  map.forEach((line, y) => {
    let inside = false;
    return line.forEach((pipe, x) => {
      if (loop.has(`${x},${y}`)) {
        if (["|", "F", "7"].includes(pipe)) inside = !inside;
      } else if (inside) {
        insideTiles++;
      }
    });
  });
  return insideTiles;
}
