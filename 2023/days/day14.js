import { loadData, sum } from "../utils.js";

export async function day14() {
  const data = await loadData(14);
  const load = countLoad(tiltNorth(parse(data)));
  const loadAfterSpinning = loadAfterSpins(parse(data), 1000000000);
  return `
  --- Day 14: Parabolic Reflector Dish ---
  Load on North after tilt: ${load}
  Load on North after too many spins: ${loadAfterSpinning}
  `;
}

function parse(input) {
  return input.split("\n").map((line) => line.split(""));
}

function tiltNorth(map) {
  for (let y = 1; y < map.length; y++) {
    for (let x = 0; x < map[0].length; x++) {
      if (map[y][x] === "O") {
        let newY = y;
        while (newY > 0 && map[newY - 1][x] === ".") {
          newY--;
        }
        map[newY][x] = "O";
        if (newY !== y) map[y][x] = ".";
      }
    }
  }

  return map;
}

function tiltSouth(map) {
  for (let y = map.length - 1; y >= 0; y--) {
    for (let x = 0; x < map[0].length; x++) {
      if (map[y][x] === "O") {
        let newY = y;
        while (newY < map.length - 1 && map[newY + 1][x] === ".") {
          newY++;
        }
        map[newY][x] = "O";
        if (newY !== y) map[y][x] = ".";
      }
    }
  }

  return map;
}

function tiltWest(map) {
  for (let y = 0; y < map.length; y++) {
    for (let x = 0; x < map[0].length; x++) {
      if (map[y][x] === "O") {
        let newX = x;
        while (newX > 0 && map[y][newX - 1] === ".") {
          newX--;
        }
        map[y][newX] = "O";
        if (newX !== x) map[y][x] = ".";
      }
    }
  }

  return map;
}

function tiltEast(map) {
  for (let y = 0; y < map.length; y++) {
    for (let x = map[0].length; x >= 0; x--) {
      if (map[y][x] === "O") {
        let newX = x;
        while (newX <= map[0].length && map[y][newX + 1] === ".") {
          newX++;
        }
        map[y][newX] = "O";
        if (newX !== x) map[y][x] = ".";
      }
    }
  }

  return map;
}

function spin(map, times = 1) {
  for (let i = 0; i < times; i++) {
    tiltEast(tiltSouth(tiltWest(tiltNorth(map))));
  }
  return map;
}

function countLoad(map) {
  return sum(
    map.map((line, index) =>
      line.reduce(
        (total, point) => (point === "O" ? total + map.length - index : total),
        0
      )
    )
  );
}

function stringify(map) {
  return map.map((line) => line.join("")).join("\n");
}

function spinRepeatsAfter(map) {
  let count = 0;
  const maps = new Map();
  maps.set(stringify(spin(map)), 1);

  let s = stringify(spin(map));
  count++;
  let getMap = maps.get(s);
  while (typeof getMap === "undefined") {
    maps.set(s, count);
    s = stringify(spin(map));
    getMap = maps.get(s);
    count++;
  }
  return count;
}

function findRepeat(map) {
  let repeatIndex = spinRepeatsAfter(map);
  let previousRepeat = 0;
  let count = repeatIndex + 1;
  while (repeatIndex !== previousRepeat) {
    previousRepeat = repeatIndex;
    repeatIndex = spinRepeatsAfter(map);
    count += repeatIndex + 1;
  }
  return [repeatIndex, count];
}

function loadAfterSpins(map, spins) {
  const [repeat, count] = findRepeat(map);
  const remainingSpins = (spins - count) % repeat;
  return countLoad(spin(map, remainingSpins));
}
