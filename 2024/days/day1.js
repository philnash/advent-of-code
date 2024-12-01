import { loadData, sum } from "../utils.js";

export async function day1() {
  const day1data = await loadData(1);
  const lists = parse(day1data);
  return `
  --- Day 1: Historian Hysteria ---
  The total distance is ${listDistance(lists)}
  The similarity is ${listSimilarity(lists)}
  `;
}

function parse(str) {
  const lists = [[], []];
  str
    .split("\n")
    .map((line) =>
      line
        .split(/\s+/)
        .map((col, index) => lists[index].push(parseInt(col, 10)))
    );
  return lists;
}

function sortInts(a, b) {
  return b - a;
}

export function listDistance([listA, listB]) {
  const sortedA = listA.toSorted(sortInts);
  const sortedB = listB.toSorted(sortInts);

  return sortedA.reduce(
    (acc, num, index) => acc + Math.abs(num - sortedB[index]),
    0
  );
}

export function listSimilarity([listA, listB]) {
  const counts = listB.reduce((acc, num) => {
    acc[num] = acc[num] ? acc[num] + 1 : 1;
    return acc;
  }, {});
  return sum(listA.map((num) => num * counts[num] || 0));
}
