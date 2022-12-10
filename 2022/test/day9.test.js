import { describe, it } from "node:test";
import assert from "node:assert";
import { parse, moveRope, reconcileTail } from "../days/day9.js";

const testData = `R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2`;

describe("day 9", () => {
  describe("utils", () => {
    it("the tail doesn't move when the head is on top", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 0, y: 0 }), {
        x: 0,
        y: 0,
      });
    });

    it("doesn't move when touching to the right", () => {
      assert.deepStrictEqual(reconcileTail({ x: 1, y: 0 }, { x: 0, y: 0 }), {
        x: 0,
        y: 0,
      });
    });

    it("doesn't move when touching to the left", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 1, y: 0 }), {
        x: 1,
        y: 0,
      });
    });

    it("doesn't move when touching above", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 1 }, { x: 0, y: 0 }), {
        x: 0,
        y: 0,
      });
    });

    it("doesn't move when touching below", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 0, y: 1 }), {
        x: 0,
        y: 1,
      });
    });

    it("doesn't move when touching diagonally", () => {
      assert.deepStrictEqual(reconcileTail({ x: 1, y: 1 }, { x: 0, y: 0 }), {
        x: 0,
        y: 0,
      });
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 1, y: 1 }), {
        x: 1,
        y: 1,
      });
    });

    it("moves right to catch up horizontally", () => {
      assert.deepStrictEqual(reconcileTail({ x: 2, y: 0 }, { x: 0, y: 0 }), {
        x: 1,
        y: 0,
      });
    });

    it("moves left to catch up horizontally", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 2, y: 0 }), {
        x: 1,
        y: 0,
      });
    });

    it("moves up to catch up vertically", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 0, y: 2 }), {
        x: 0,
        y: 1,
      });
    });

    it("moves down to catch up vertically", () => {
      assert.deepStrictEqual(reconcileTail({ x: 0, y: 2 }, { x: 0, y: 0 }), {
        x: 0,
        y: 1,
      });
    });

    it("moves diagonally to catch up", () => {
      assert.deepStrictEqual(reconcileTail({ x: 1, y: 2 }, { x: 0, y: 0 }), {
        x: 1,
        y: 1,
      });

      assert.deepStrictEqual(reconcileTail({ x: 2, y: 1 }, { x: 0, y: 0 }), {
        x: 1,
        y: 1,
      });

      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 1, y: 2 }), {
        x: 0,
        y: 1,
      });

      assert.deepStrictEqual(reconcileTail({ x: 0, y: 0 }, { x: 2, y: 1 }), {
        x: 1,
        y: 0,
      });

      assert.deepStrictEqual(
        reconcileTail({ x: -3, y: -4 }, { x: -1, y: -2 }),
        {
          x: -2,
          y: -3,
        }
      );
    });
  });

  describe("part 1", () => {
    it("counts the tail positions", () => {
      const moves = parse(testData);
      assert.strictEqual(moveRope(moves), 13);
    });
  });

  describe("part 2", () => {
    it("counts the positions of the end of the rope", () => {
      const moves = parse(testData);
      assert.strictEqual(moveRope(moves, 10), 1);
    });

    it("counts the positions for new data", () => {
      const testData = `R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20`;
      const moves = parse(testData);
      assert.strictEqual(moveRope(moves, 10), 36);
    });
  });
});
