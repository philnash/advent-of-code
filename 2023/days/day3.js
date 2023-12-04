import { loadData } from "../utils.js";

export async function day3() {
  const day3data = await loadData(3);
  const schematic = parse(day3data);
  return `
  --- Day 3: Gear Ratios ---
  Sum of the part numbers: ${countPartNumbers(schematic)}
  Sum of the gear rations: ${findGears(possibleGears(schematic))}
  `;
}

function parse(input) {
  return input.split("\n").map((line) => line.split(""));
}

class Point {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  eq(other) {
    return this.x === other.x && this.y === other.y;
  }
}

function createSymbolPositions(i, j, row, line, map) {
  return [
    new Point(i - 1, row - 1),
    new Point(i - 1, row),
    new Point(i - 1, row + 1),
    new Point(j, row - 1),
    new Point(j, row),
    new Point(j, row + 1),
    ...Array(j - i)
      .fill(null)
      .map((_, k) => new Point(i + k, row - 1)),
    ...Array(j - i)
      .fill(null)
      .map((_, k) => new Point(i + k, row + 1)),
  ].filter(
    (point) =>
      point.x >= 0 &&
      point.y >= 0 &&
      point.x < line.length &&
      point.y < map.length
  );
}

function countPartNumbers(map) {
  return map.reduce((total, line, row) => {
    let i = 0,
      lineTotal = 0;
    while (i < line.length) {
      if (line[i].match(/\d/)) {
        let j = i + 1;
        let possiblePartNumber = line[i];
        while (j < line.length && line[j].match(/\d/)) {
          possiblePartNumber += line[j];
          j++;
        }
        let symbolPositions = createSymbolPositions(i, j, row, line, map);
        if (
          symbolPositions.some(
            (point) =>
              !(
                map[point.y][point.x].match(/\d/) ||
                map[point.y][point.x] === "."
              )
          )
        ) {
          lineTotal += parseInt(possiblePartNumber, 10);
          i = j;
        } else {
          i++;
        }
      } else {
        i++;
      }
    }
    return total + lineTotal;
  }, 0);
}

function possibleGears(map) {
  return map.reduce((partsAndGears, line, row) => {
    let i = 0;
    while (i < line.length) {
      if (line[i].match(/\d/)) {
        let j = i + 1;
        let possiblePartNumber = line[i];
        while (j < line.length && line[j].match(/\d/)) {
          possiblePartNumber += line[j];
          j++;
        }
        let symbolPositions = createSymbolPositions(i, j, row, line, map);
        for (const point of symbolPositions) {
          if (map[point.y][point.x] === "*") {
            partsAndGears.push({
              part: parseInt(possiblePartNumber, 10),
              gear: point,
            });
            break;
          }
        }
        i = j;
      } else {
        i++;
      }
    }
    return partsAndGears;
  }, []);
}

function findGears(partsAndGears) {
  let total = 0;
  let partAndGear = partsAndGears.pop();
  while (partAndGear) {
    const match = partsAndGears.find((pag) => pag.gear.eq(partAndGear.gear));
    if (match) {
      total += partAndGear.part * match.part;
    }
    partAndGear = partsAndGears.pop();
  }
  return total;
}

// console.log(
//   findGears(
//     possibleGears(
//       parse(`467..114..
// ...*......
// ..35..633.
// ......#...
// 617*......
// .....+.58.
// ..592.....
// ......755.
// ...$.*....
// .664.598..`)
//     )
//   )
// );
