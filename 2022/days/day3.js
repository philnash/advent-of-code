import { loadData, sum } from "../utils.js";

export async function day3() {
  const data = await loadData(3);
  return `
    --- Day 3: Rucksack Reorganization ---
    The sum of item priorities that appear in both compartments is ${sumOfItemPrioritiesFromBothCompartments(
      data
    )}
    The sum of badge priorities is ${sumOfBadgePriorities(data)}
  `;
}

export function sumOfItemPrioritiesFromBothCompartments(data) {
  return sum(
    data
      .split("\n")
      .map((line) => compartmentsFromItems(line))
      .map((items) => itemInBothCompartments(items))
      .map((item) => itemToPriority(item))
  );
}

export function sumOfBadgePriorities(data) {
  return sum(
    inGroupsOfThree(data.split("\n"))
      .map((group) => itemInThreeBags(group.map((bag) => bag.split(""))))
      .map((item) => itemToPriority(item))
  );
}

export function compartmentsFromItems(items) {
  const arrayOfItems = items.split("");
  return [
    arrayOfItems.slice(0, arrayOfItems.length / 2),
    arrayOfItems.slice(arrayOfItems.length / 2),
  ];
}

export function itemInBothCompartments([compartmentA, compartmentB]) {
  return compartmentA.filter((item) => compartmentB.includes(item))[0];
}

export function itemInThreeBags([bagA, bagB, bagC]) {
  return bagA.filter((item) => bagB.includes(item) && bagC.includes(item))[0];
}

export function itemToPriority(item) {
  const code = item.charCodeAt(0);
  return code >= 97 ? code - 96 : code - 38;
}

export function inGroupsOfThree(array) {
  return array.reduce((acc, curr, index) => {
    return (index % 3 ? acc.at(-1).push(curr) : acc.push([curr])) && acc;
  }, []);
}
