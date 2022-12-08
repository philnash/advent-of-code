import { describe, it } from "node:test";
import assert from "node:assert";
import {
  isVisible,
  isVisibleLeft,
  isVisibleRight,
  isVisibleDown,
  isVisibleUp,
  scenicScoreLeft,
  scenicScoreRight,
  scenicScoreUp,
  scenicScoreDown,
  countVisibleTrees,
  findHighestScenicCount,
} from "../days/day8.js";

const testData = `30373
25512
65332
33549
35390`;

const testMap = [
  [3, 0, 3, 7, 3],
  [2, 5, 5, 1, 2],
  [6, 5, 3, 3, 2],
  [3, 3, 5, 4, 9],
  [3, 5, 3, 9, 0],
];

describe("day 8", () => {
  describe("utils", () => {
    describe("working out whether a single tree is visible", () => {
      it("is visible on the left edge", () => {
        assert.ok(isVisible(0, 2, testMap));
      });
      it("is visible on the top edge", () => {
        assert.ok(isVisible(2, 0, testMap));
      });
      it("is visible on the right edge", () => {
        assert.ok(isVisible(4, 0, testMap));
      });
      it("is visible on the bottom edge", () => {
        assert.ok(isVisible(2, 4, testMap));
      });
      it("is visible in the middle", () => {
        assert.ok(isVisible(1, 1, testMap));
      });
      it("is not visible if surrounded", () => {
        assert.ok(!isVisible(3, 1, testMap));
      });

      it("is visible to the left", () => {
        assert.ok(isVisibleLeft(1, 1, testMap));
      });
      it("is not visible to the left", () => {
        assert.ok(!isVisibleLeft(1, 2, testMap));
      });

      it("is visible to the right", () => {
        assert.ok(isVisibleRight(1, 2, testMap));
      });
      it("is not visible to the right", () => {
        assert.ok(!isVisibleRight(1, 1, testMap));
      });

      it("is visible up", () => {
        assert.ok(isVisibleUp(1, 1, testMap));
      });
      it("is not visible up", () => {
        assert.ok(!isVisibleUp(1, 2, testMap));
      });

      it("is visible down", () => {
        assert.ok(isVisibleDown(4, 3, testMap));
      });
      it("is not visible down", () => {
        assert.ok(!isVisibleDown(1, 1, testMap));
      });
    });

    describe("scenic scores", () => {
      it("calculates the scenic score left", () => {
        assert.strictEqual(scenicScoreLeft(2, 1, testMap), 1);
        assert.strictEqual(scenicScoreLeft(2, 3, testMap), 2);
      });

      it("calculates the scenic score right", () => {
        assert.strictEqual(scenicScoreRight(2, 1, testMap), 2);
        assert.strictEqual(scenicScoreRight(2, 3, testMap), 2);
      });

      it("calculates the scenic score down", () => {
        assert.strictEqual(scenicScoreDown(2, 1, testMap), 2);
        assert.strictEqual(scenicScoreDown(2, 3, testMap), 1);
      });

      it("calculates the scenic score up", () => {
        assert.strictEqual(scenicScoreUp(2, 1, testMap), 1);
        assert.strictEqual(scenicScoreUp(2, 3, testMap), 2);
      });
    });

    describe("part 1", () => {
      it("counts visible trees", () => {
        assert.strictEqual(countVisibleTrees(testData), 21);
      });
    });

    describe("part 2", () => {
      it("finds the highest scenic count", () => {
        assert.strictEqual(findHighestScenicCount(testData), 8);
      });
    });
  });
});
