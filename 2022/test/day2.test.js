import { describe, it } from "node:test";
import assert from "assert";
import { strategyOne, strategyTwo } from "../days/day2.js";

const testData = `A Y
B X
C Z`;

describe("part 1", () => {
  it("scores the game", () => {
    assert.strictEqual(strategyOne(testData), 15);
  });
});

describe("part 2", () => {
  it("scores the game differently", () => {
    assert.strictEqual(strategyTwo(testData), 12);
  });
});
