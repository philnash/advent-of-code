import { loadData } from "../utils.js";

const bigZero = BigInt(0);
const bigThree = BigInt(3);
const compareNumbers = (a, b) => b - a;

export async function day11() {
  const data = await loadData(11);
  const monkeys = parse(data);
  return `
    --- Day 11: Monkey in the Middle ---
    Monkey Business: ${monkeyRounds(monkeys, 20)}
    Mega Monkey Business: ${monkeyRounds(parse(data), 10_000, false)}
  `;
}

class Monkey {
  /**
   *
   * @param {bigint[]} items
   * @param {string} operation
   * @param {bigint | string} value
   * @param {bigint} testDivisor
   * @param {number} trueMonkey
   * @param {number} falseMonkey
   */
  constructor(items, operation, value, testDivisor, trueMonkey, falseMonkey) {
    this.items = items;
    this.operation = operation;
    this.value = value;
    this.testDivisor = testDivisor;
    this.trueMonkey = trueMonkey;
    this.falseMonkey = falseMonkey;
    this.itemInspections = 0;
  }

  inspect(calming = true) {
    let item = this.items.shift();
    if (item) {
      const value = typeof this.value === "string" ? item : this.value;
      if (this.operation === "*") {
        item = item * value;
      } else {
        item = item + value;
      }
      if (calming) {
        item = item / bigThree;
      }
      this.itemInspections++;
      if (item % this.testDivisor === bigZero) {
        return { item, throwTo: this.trueMonkey };
      } else {
        return { item, throwTo: this.falseMonkey };
      }
    }
  }

  reduceWorry(modulo) {
    this.items = this.items.map((item) => item % modulo);
  }
}

export function parse(data) {
  const monkeyData = data.split("\n\n");
  return monkeyData.map((monkeyData) => {
    const monkeyLines = monkeyData.split("\n");
    const items = monkeyLines[1]
      .split(": ")[1]
      .split(", ")
      .map((x) => BigInt(parseInt(x, 10)));
    let [operation, value] = monkeyLines[2]
      .trim()
      .replace("Operation: new = old ", "")
      .split(" ");
    value = parseInt(value, 10) ? BigInt(parseInt(value, 10)) : value;
    const testDivisor = BigInt(
      parseInt(monkeyLines[3].trim().replace("Test: divisible by ", ""), 10)
    );
    const trueMonkey = parseInt(
      monkeyLines[4].trim().replace("If true: throw to monkey ", ""),
      10
    );
    const falseMonkey = parseInt(
      monkeyLines[5].trim().replace("If false: throw to monkey ", ""),
      10
    );
    return new Monkey(
      items,
      operation,
      value,
      testDivisor,
      trueMonkey,
      falseMonkey
    );
  });
}

export function monkeyRounds(monkeys, rounds, calming) {
  const monkeyModulo = monkeys
    .map((m) => m.testDivisor)
    .reduce((acc, curr) => curr * acc, BigInt(1));
  for (let round = 0; round < rounds; round++) {
    monkeys.forEach((monkey) => {
      monkey.reduceWorry(monkeyModulo);
      while (monkey.items.length > 0) {
        const { item, throwTo } = monkey.inspect(calming);
        monkeys[throwTo].items.push(item);
      }
    });
  }
  const inspections = monkeys
    .map((monkey) => monkey.itemInspections)
    .sort(compareNumbers);
  return inspections[0] * inspections[1];
}
