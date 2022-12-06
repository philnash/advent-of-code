import { describe, it } from "node:test";
import assert from "node:assert";
import { createStacks, rearrange9000, rearrange9001 } from "../days/day5.js";

// prettier-ignore
const testData = `    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2`;

describe("day 5", () => {
  describe("utils", () => {
    describe("createStacks", () => {
      it("creates an array of stacks", () => {
        const testStacks = `    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 `.split("\n");
        assert.deepStrictEqual(createStacks(testStacks), [
          ["Z", "N"],
          ["M", "C", "D"],
          ["P"],
        ]);
      });
    });
  });

  describe("part 1", () => {
    it("moves the crates and returns the top row", () => {
      assert.strictEqual(rearrange9000(testData), "CMZ");
    });
  });

  describe("part 2", () => {
    it("moves the crates and returns the top row", () => {
      assert.strictEqual(rearrange9001(testData), "MCD");
    });
  });
});
