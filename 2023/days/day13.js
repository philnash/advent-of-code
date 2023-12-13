import { loadData, sum } from "../utils.js";

export async function day13() {
  const data = await loadData(13);
  const areas = parse(data);
  const hAndV = areas.map((area) => [
    testHorizontalReflection(area),
    testVerticalReflection(area),
  ]);
  const summary = sum(hAndV.map(([h, u]) => h * 100 + u));

  const smudgedHandV = areas.map((area) => [
    testHorizontalReflection(area, 1),
    testVerticalReflection(area, 1),
  ]);
  const summary2 = sum(smudgedHandV.map(([h, u]) => h * 100 + u));
  return `
  --- Day 13: ---
  Summary of reflections: ${summary}
  Summary of reflections with smudges: ${summary2}
  `;
}

function parse(input) {
  return input
    .split("\n\n")
    .map((area) => area.split("\n").map((line) => line.split("")));
}

function differencesInLines(line1, line2) {
  return sum(line1.map((value, index) => (value === line2[index] ? 0 : 1)));
}

function testHorizontalReflection(area, smudges = 0) {
  const rows = area
    .map((row, index) => {
      if (!area[index + 1]) return;
      let diff = differencesInLines(row, area[index + 1]);
      if (diff <= smudges) {
        let i = index - 1;
        let j = index + 2;
        while (i >= 0 && j < area.length) {
          diff += differencesInLines(area[i], area[j]);
          if (diff <= smudges) {
            i--;
            j++;
          } else {
            return undefined;
          }
        }
        return diff === smudges ? index + 1 : 0;
      }
    })
    .filter(Boolean);
  return rows.at(0) || 0;
}

function testVerticalReflection(area, smudges = 0) {
  const newArea = new Array(area[0].length).fill(null).map(() => []);
  for (let y = 0; y < area.length; y++) {
    for (let x = 0; x < area[0].length; x++) {
      newArea[x][y] = area[y][x];
    }
  }
  return testHorizontalReflection(newArea, smudges);
}
