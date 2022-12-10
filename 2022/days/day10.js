import { loadData, sum } from "../utils.js";

export async function day10() {
  const data = await loadData(10);
  return `
--- Day 10: Cathode-Ray Tube ---
Sum of signal strengths: ${sumOfSignalStrengths(data)}
CRT Output:
${drawCrt(data)}
  `;
}

/**
 *
 * @param {string} data
 * @returns { {instruction: string; value: number;}[] }
 */
function parse(data) {
  return data.split("\n").flatMap((line) => {
    const [instruction, value] = line.split(" ");
    if (instruction === "addx") {
      return [
        { instruction: "noop", value: NaN },
        { instruction, value: parseInt(value, 10) },
      ];
    }
    return { instruction: "noop", value: NaN };
  });
}

/**
 *
 * @param {string} data
 * @param {number} cycles
 */
export function runProgram(data, cycles) {
  const instructions = parse(data);
  let register = 1;
  for (let clock = 0; clock < cycles; clock++) {
    if (instructions[clock].instruction === "noop") {
    } else {
      register += instructions[clock].value;
    }
  }
  return register;
}

function sumOfSignalStrengths(data) {
  return sum(
    [20, 60, 100, 140, 180, 220].map(
      (cycles) => cycles * runProgram(data, cycles - 1)
    )
  );
}

export function drawCrt(data) {
  const instructions = parse(data);
  let register = 1;
  let output = "";
  instructions.forEach(({ instruction, value }, index) => {
    if (index % 40 === 0) {
      output += "\n";
    }
    output += [register - 1, register, register + 1].includes(index % 40)
      ? "#"
      : ".";
    if (instruction === "addx") {
      register += value;
    }
  });
  return output;
}
