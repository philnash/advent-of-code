import { loadData, sum } from "../utils.js";

export async function day13() {
  const data = await loadData(13);
  return `
    --- Day 13: Distress Signal ---
    Sum of indices of correctly ordered lists: ${sumOfIndicesOfCorrectlyOrderedLists(
      data
    )}
    Decoder Key: ${decoderKey(data, [[2]], [[6]])}
  `;
}

export function sumOfIndicesOfCorrectlyOrderedLists(data) {
  const result = parse(data).map(([left, right], index) => {
    return compareLists(left, right) === 1 ? index + 1 : 0;
  });
  return sum(result);
}

export function parse(data) {
  return data
    .split("\n\n")
    .map((pair) => pair.split("\n"))
    .map(([left, right]) => {
      return [JSON.parse(left), JSON.parse(right)];
    });
}

function parseIntoList(data) {
  return data
    .split("\n")
    .filter((line) => line.length > 0)
    .map((line) => JSON.parse(line));
}

export function sortLists(data, extras = []) {
  return parseIntoList(data).concat(extras).sort(compareLists).reverse();
}

export function decoderKey(data, divider1, divider2) {
  const sortedList = sortLists(data, [divider1, divider2]);
  return (
    (sortedList.indexOf(divider1) + 1) * (sortedList.indexOf(divider2) + 1)
  );
}

export function compareLists(left, right) {
  let comparison;
  if (typeof left[0] === "number" && typeof right[0] === "number") {
    comparison = compareIntegers(left[0], right[0]);
  } else if (
    typeof left[0] === "undefined" &&
    typeof right[0] !== "undefined"
  ) {
    comparison = 1;
  } else if (
    typeof left[0] !== "undefined" &&
    typeof right[0] === "undefined"
  ) {
    comparison = -1;
  } else if (
    typeof left[0] === "undefined" &&
    typeof right[0] === "undefined"
  ) {
    return 0;
  } else if (typeof left[0] === "number" && typeof right[0] === "object") {
    comparison = compareLists([left[0]], right[0]);
  } else if (typeof left[0] === "object" && typeof right[0] === "number") {
    comparison = compareLists(left[0], [right[0]]);
  } else if (typeof left[0] === "object" && typeof right[0] === "object") {
    comparison = compareLists(left[0], right[0]);
  }
  if (comparison === 0) {
    return compareLists(left.slice(1), right.slice(1));
  } else {
    if (typeof comparison === "undefined") {
      console.log(
        `Undefined with ${JSON.stringify(left)} and ${JSON.stringify(right)}`
      );
    }
    return comparison;
  }
}

export function compareIntegers(left, right) {
  return left < right ? 1 : right < left ? -1 : 0;
}
