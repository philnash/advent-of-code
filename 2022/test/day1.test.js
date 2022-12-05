import { describe, it } from "node:test";
import assert from "assert";
import {
  elfWithMostCalories,
  topThreeElvesWithMostCalories,
} from "../days/day1.js";

const testData = `1000
2000
3000

4000

5000
6000

7000
8000
9000

10000`;

describe("day 1", () => {
  describe("part 1", () => {
    it("calculates the number of calories carried by the elf with the most calories", () => {
      assert.strictEqual(elfWithMostCalories(testData), 24000);
    });
  });

  describe("part 2", () => {
    it("calculates the total calories of the top three elves", () => {
      assert.strictEqual(topThreeElvesWithMostCalories(testData), 45000);
    });
  });
});
