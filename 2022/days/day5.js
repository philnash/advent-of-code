import { loadData } from "../utils.js";

export async function day5() {
  const data = await loadData(5);
  return `
    --- Day 5: Supply Stacks ---
    Top crates for the 9000 are: ${rearrange9000(data)}
    Top crates for the 9001 are: ${rearrange9001(data)}
  `;
}

function parseData(data) {
  const [stackData, moveData] = data
    .split("\n\n")
    .map((part) => part.split("\n"));
  const stacks = createStacks(stackData);
  const moves = parseMoves(moveData);
  return [stacks, moves];
}

export function rearrange9000(data) {
  const [stacks, moves] = parseData(data);
  moves.forEach(([totalCrates, from, to]) => {
    let moved = 0;
    while (moved < totalCrates) {
      stacks[to - 1].push(stacks[from - 1].pop());
      moved += 1;
    }
  });
  return stacks.map((stack) => stack.at(-1)).join("");
}

export function rearrange9001(data) {
  const [stacks, moves] = parseData(data);
  moves.forEach(([totalCrates, from, to]) => {
    const moving = stacks[from - 1].splice(
      stacks[from - 1].length - totalCrates,
      totalCrates
    );
    stacks[to - 1] = stacks[to - 1].concat(moving);
  });
  return stacks.map((stack) => stack.at(-1)).join("");
}

export function createStacks(lines) {
  const numbers = lines.pop();
  const numberOfStacks = numbers.trim().split(/\s+/).length;
  const stacks = new Array(numberOfStacks);
  lines.forEach((line) => {
    let pointer = 0;
    while (pointer * 4 < line.length) {
      if (line[pointer * 4] === "[") {
        if (typeof stacks[pointer] === "undefined") {
          stacks[pointer] = [];
        }
        stacks[pointer].unshift(line[pointer * 4 + 1]);
      }
      pointer += 1;
    }
  });
  return stacks;
}

export function parseMoves(moveData) {
  return moveData.map((line) => {
    const matchData = line.match(/move (\d+) from (\d+) to (\d+)/);
    return matchData.slice(1, 4).map((str) => parseInt(str, 10));
  });
}

const testStacks = `    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2`;
console.log(rearrange9000(testStacks));
