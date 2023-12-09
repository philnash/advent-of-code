import { loadData, sum } from "../utils.js";

export async function day9() {
  const data = await loadData(9);
  const input = parse(data);
  return `
  --- Day 9: Mirage Maintenance ---
  ${sumNextValues(input)}
  ${sumPrevValues(input)}
  `;
}

function parse(input) {
  return input
    .split("\n")
    .map((line) => line.split(" ").map((str) => parseInt(str, 10)));
}

function predict(history) {
  const difference = [];
  for (let i = 0; i < history.length - 1; i++) {
    difference.push(history[i + 1] - history[i]);
  }
  if (difference.every((item) => item === 0)) {
    return history.at(-1);
  } else {
    return history.at(-1) + predict(difference);
  }
}

function predictBackwards(history) {
  const difference = [];
  for (let i = 0; i < history.length - 1; i++) {
    difference.push(history[i + 1] - history[i]);
  }
  if (difference.every((item) => item === 0)) {
    return history.at(0);
  } else {
    return history.at(0) - predictBackwards(difference);
  }
}

function sumNextValues(input) {
  return sum(input.map(predict));
}

function sumPrevValues(input) {
  return sum(input.map(predictBackwards));
}
