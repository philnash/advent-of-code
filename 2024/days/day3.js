import { loadData, sum } from "../utils.js";

export async function day3() {
  const day3data = await loadData(3);

  return `
  --- Day 3: Mull It Over ---
  Result: ${parseMuls(day3data)}
  Result with conditionals: ${parseMulsAndConditionals(day3data)}
  `;
}

function mul(input) {
  const nums = input
    .match(/(\d{1,3}),(\d{1,3})/)
    .map((num) => parseInt(num, 10));
  return nums[1] * nums[2];
}

function parseMuls(input) {
  const matches = input.match(/mul\(\d{1,3},\d{1,3}\)/g);
  return sum(matches.map(mul));
}

function parseMulsAndConditionals(input) {
  const matches = input.match(/(mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))/g);
  let execute = true;
  return sum(
    matches.map((op) => {
      if (op === "do()") {
        execute = true;
        return 0;
      }
      if (op === "don't()") {
        execute = false;
        return 0;
      }
      if (!execute) {
        return 0;
      }

      return mul(op);
    })
  );
}
