import { loadData } from "../utils.js";

export async function day4() {
  const data = await loadData(4);
  return `
    --- Day 4: Camp Cleanup ---
    Fully overlapping pairs: ${fullyOverlappingPairs(data)}
    Overlapping pairs: ${overlappingPairs(data)}
  `;
}

/**
 *
 * @param {string} data
 */
export function fullyOverlappingPairs(data) {
  return dataToPairs(data).filter(
    ([a, b]) => (a[0] >= b[0] && a[1] <= b[1]) || (b[0] >= a[0] && b[1] <= a[1])
  ).length;
}

export function overlappingPairs(data) {
  return dataToPairs(data).filter(
    ([a, b]) =>
      (a[0] >= b[0] && a[0] <= b[1]) ||
      (a[1] >= b[0] && a[1] <= b[1]) ||
      (b[0] >= a[0] && b[0] <= a[1]) ||
      (b[1] >= a[0] && b[1] <= a[1])
  ).length;
}

function dataToPairs(data) {
  return data
    .split("\n")
    .map((lines) =>
      lines
        .split(",")
        .map((pairs) =>
          pairs.split("-").map((section) => parseInt(section, 10))
        )
    );
}
