import { loadData } from "../utils.js";

export async function day12() {
  const data = await loadData(12);
  const heightMap = parse(data);
  return `
    --- Day 12:  Hill Climbing Algorithm ---
    Shortest path to E: ${findPath(heightMap)}
    Shortest path from lowest: ${findShortestPathFromLowest(heightMap)}
  `;
}

export function parse(data) {
  return data.split("\n").map((line) =>
    line.split("").map((char) => {
      if (char === "S" || char === "E") {
        return char;
      } else {
        return char.charCodeAt();
      }
    })
  );
}

export function findSquare(heightMap, square) {
  for (let y = 0; y < heightMap.length; y++) {
    for (let x = 0; x < heightMap[y].length; x++) {
      if (heightMap[y][x] === square) {
        return { x, y };
      }
    }
  }
}

export function findSquares(heightMap, square) {
  const squares = [];
  const number = square.charCodeAt();
  for (let y = 0; y < heightMap.length; y++) {
    for (let x = 0; x < heightMap[y].length; x++) {
      if (heightMap[y][x] === number || heightMap[y][x] === "S") {
        squares.push({ x, y, distance: 0 });
      }
    }
  }
  return squares;
}

export function nextMoves(heightMap, { x, y, distance }) {
  return [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
  ]
    .map(([deltaX, deltaY]) => {
      const nextX = x + deltaX;
      const nextY = y + deltaY;
      if (
        nextX >= heightMap[0].length ||
        nextX < 0 ||
        nextY >= heightMap.length ||
        nextY < 0
      ) {
        return null;
      }
      const currentSquare = square(heightMap, x, y);
      const nextSquare = square(heightMap, nextX, nextY);
      if (nextSquare <= currentSquare + 1) {
        return { x: nextX, y: nextY, distance: distance + 1 };
      } else {
        return null;
      }
    })
    .filter((square) => square !== null);
}

function square(heightMap, x, y) {
  return heightMap[y][x] === "S"
    ? 97
    : heightMap[y][x] === "E"
    ? 122
    : heightMap[y][x];
}

export function findPath(heightMap) {
  const start = findSquare(heightMap, "S");
  return findPathFromStarts(heightMap, [{ ...start, distance: 0 }]);
}

export function findShortestPathFromLowest(heightMap) {
  const starts = findSquares(heightMap, "a");
  return findPathFromStarts(heightMap, starts);
}

function findPathFromStarts(heightMap, nextMovesWithDistance) {
  const end = findSquare(heightMap, "E");
  if (nextMovesWithDistance.length > 0 && end) {
    const paths = new Array(heightMap.length);
    for (let i = 0; i < paths.length; i++) {
      paths[i] = new Array(heightMap[i].length);
      paths[i].fill(0);
    }
    while (nextMovesWithDistance.length > 0) {
      const { x, y, distance } = nextMovesWithDistance.shift();
      if (x === end.x && y === end.y) {
        return distance;
      }
      if (paths[y][x] === 0 || distance < paths[y][x]) {
        paths[y][x] = distance;
        nextMoves(heightMap, { x, y, distance }).forEach((move) =>
          nextMovesWithDistance.push(move)
        );
      }
    }
    return 0;
  }
  return 0;
}
