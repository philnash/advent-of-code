import { describe, it } from "node:test";
import assert from "node:assert";
import { parse, dropSandUntil } from "../days/day14.js";

const testData = `498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9`;

describe("day 14", () => {
  describe("part 1", () => {
    it("counts how much sand is dropped before falling into the abyss", () => {
      const map = parse(testData);
      assert.strictEqual(dropSandUntil(map), 24);
    });
  });

  describe("part 2", () => {
    it("counts the sand that piles up to the top", () => {
      const map = parse(testData);
      assert.strictEqual(dropSandUntil(map, true), 92);
    });
  });
});
