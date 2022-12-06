import { describe, it } from "node:test";
import assert from "node:assert";
import { overlappingPairs, fullyOverlappingPairs } from "../days/day4.js";

const testData = `2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8`;

describe("day 4", () => {
  describe("part 1", () => {
    it("finds the fully overlapping pairs", () => {
      assert.strictEqual(fullyOverlappingPairs(testData), 2);
    });
  });

  describe("part 2", () => {
    it("finds the overlapping pairs", () => {
      assert.strictEqual(overlappingPairs(testData), 4);
    });
  });
});
