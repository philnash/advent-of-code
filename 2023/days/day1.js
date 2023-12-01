import { loadData, sum } from "../utils.js";

export async function day1() {
  const day1data = await loadData(1);
  return `
  --- Day 1: Trebuchet?! ---
  The calibration values add up to ${calibration(day1data, extractDigits)}
  The real calibration values add up to ${calibration(
    day1data,
    extractDigitsAndNumbers
  )}
    `;
}

const mapping = {
  one: "1",
  two: "2",
  three: "3",
  four: "4",
  five: "5",
  six: "6",
  seven: "7",
  eight: "8",
  nine: "9",
};

export function extractDigits(str) {
  return str.split("").filter((num) => Number.isInteger(parseInt(num, 10)));
}

export function extractDigitsAndNumbers(str) {
  let pointer = 0;
  const numbers = [];
  while (pointer < str.length) {
    for (const key of Object.keys(mapping)) {
      if (str.slice(pointer).startsWith(key)) {
        numbers.push(mapping[key]);
        break;
      } else if (str[pointer].match(/^\d/)) {
        numbers.push(str[pointer]);
        break;
      }
    }
    pointer++;
  }
  return numbers;
}

export function calibration(str, method) {
  return sum(
    str.split("\n").map((line) => {
      const numbers = method(line);
      return parseInt(numbers[0] + numbers.at(-1), 10);
    })
  );
}
