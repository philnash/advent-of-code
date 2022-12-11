import { describe, it } from "node:test";
import assert from "node:assert";
import { parse, monkeyRounds } from "../days/day11.js";

const testData = `Monkey 0:
Starting items: 79, 98
Operation: new = old * 19
Test: divisible by 23
  If true: throw to monkey 2
  If false: throw to monkey 3

Monkey 1:
Starting items: 54, 65, 75, 74
Operation: new = old + 6
Test: divisible by 19
  If true: throw to monkey 2
  If false: throw to monkey 0

Monkey 2:
Starting items: 79, 60, 97
Operation: new = old * old
Test: divisible by 13
  If true: throw to monkey 1
  If false: throw to monkey 3

Monkey 3:
Starting items: 74
Operation: new = old + 3
Test: divisible by 17
  If true: throw to monkey 0
  If false: throw to monkey 1`;

describe("day 11", () => {
  describe("part 1", () => {
    it("calculates the monkey business after 20 rounds", () => {
      const monkeys = parse(testData);
      assert.strictEqual(monkeyRounds(monkeys, 20), 10605);
    });
  });

  describe("part 2", () => {
    it("calculates the monkey business after 10_000 rounds", () => {
      const monkeys = parse(testData);
      assert.strictEqual(monkeyRounds(monkeys, 10_000, false), 2713310158);
    });
  });
});
