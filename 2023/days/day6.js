import { loadData, product } from "../utils.js";

export async function day6() {
  const data = await loadData(6);
  const input = parse(data);
  const part2Input = parse2(data);
  return `
  --- Day 6: Wait For It ---
  Margin of error for the races: ${marginOfError(input)}
  Number of ways to win the one big race: ${marginOfError(part2Input)}
  `;
}

function parse(input) {
  return input
    .split("\n")
    .map((line) => line.match(/(\d+)/g).map((str) => parseInt(str, 10)));
}

function parse2(input) {
  return input
    .split("\n")
    .map((line) => [parseInt(line.match(/(\d+)/g).join(""), 10)]);
}

function waysToBeatRecord(time, distance) {
  let numberOfWins = 0;
  for (let i = 1; i < time; i++) {
    if (i * (time - i) > distance) {
      numberOfWins++;
    }
  }
  return numberOfWins;
}

function marginOfError([times, distances]) {
  const winningTimes = [];
  for (let i = 0; i < times.length; i++) {
    winningTimes.push(waysToBeatRecord(times[i], distances[i]));
  }
  return product(winningTimes);
}
