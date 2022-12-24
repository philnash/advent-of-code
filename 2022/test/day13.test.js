import { describe, it } from "node:test";
import assert from "node:assert";
import {
  compareIntegers,
  parse,
  compareLists,
  sumOfIndicesOfCorrectlyOrderedLists,
  sortLists,
  decoderKey,
} from "../days/day13.js";

const testData = `[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]`;

describe("day 13", () => {
  describe("utils", () => {
    describe("parsing", () => {
      it("parses into pairs of lists", () => {
        const testData = `[1,1,3,1,1]
[1,1,5,1,1]`;
        assert.deepStrictEqual(parse(testData), [
          [
            [1, 1, 3, 1, 1],
            [1, 1, 5, 1, 1],
          ],
        ]);
      });
    });

    describe("comparing integers", () => {
      it("returns 1 if the left is less than the right", () => {
        assert.strictEqual(compareIntegers(1, 2), 1);
      });
      it("returns -1 if the right is less than the left", () => {
        assert.strictEqual(compareIntegers(3, 2), -1);
      });
      it("returns 0 if the left and right are equal", () => {
        assert.strictEqual(compareIntegers(1, 1), 0);
      });
    });

    describe("comparing lists", () => {
      it("returns 1 if the left has an item lower than the right", () => {
        assert.strictEqual(compareLists([1], [2]), 1);
      });

      it("returns 1 if the left runs out before the right", () => {
        assert.strictEqual(compareLists([1], [1, 2]), 1);
      });

      it("returns 1 if the left half is empty", () => {
        assert.strictEqual(compareLists([], [3]), 1);
      });

      it("returns -1 if the right has an item lower than the left", () => {
        assert.strictEqual(compareLists([9], [8, 2]), -1);
      });

      it("returns -1 if the right runs out before the left", () => {
        assert.strictEqual(compareLists([7, 7, 7, 7], [7, 7, 7]), -1);
      });

      it("returns -1 if the right half is empty", () => {
        assert.strictEqual(compareLists([[]], []), -1);
      });

      it("works against all the examples", () => {
        assert.strictEqual(compareLists([1, 1, 3, 1, 1], [1, 1, 5, 1, 1]), 1);
        assert.strictEqual(compareLists([[1], [2, 3, 4]], [[1], 4]), 1);
        assert.strictEqual(compareLists([9], [[8, 7, 6]]), -1);
        assert.strictEqual(compareLists([[4, 4], 4, 4], [[4, 4], 4, 4, 4]), 1);
        assert.strictEqual(compareLists([[[]]], [[]]), -1);
        assert.strictEqual(
          compareLists(
            [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
            [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]
          ),
          -1
        );
      });
    });

    describe("sorting lists", () => {
      it("sorts in ascending order", () => {
        const result = [
          [],
          [[]],
          [[[]]],
          [1, 1, 3, 1, 1],
          [1, 1, 5, 1, 1],
          [[1], [2, 3, 4]],
          [1, [2, [3, [4, [5, 6, 0]]]], 8, 9],
          [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
          [[1], 4],
          [3],
          [[4, 4], 4, 4],
          [[4, 4], 4, 4, 4],
          [7, 7, 7],
          [7, 7, 7, 7],
          [[8, 7, 6]],
          [9],
        ];

        assert.deepStrictEqual(sortLists(testData), result);
      });

      it("sorts with additions in ascending order", () => {
        const result = [
          [],
          [[]],
          [[[]]],
          [1, 1, 3, 1, 1],
          [1, 1, 5, 1, 1],
          [[1], [2, 3, 4]],
          [1, [2, [3, [4, [5, 6, 0]]]], 8, 9],
          [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
          [[1], 4],
          [[2]],
          [3],
          [[4, 4], 4, 4],
          [[4, 4], 4, 4, 4],
          [[6]],
          [7, 7, 7],
          [7, 7, 7, 7],
          [[8, 7, 6]],
          [9],
        ];

        assert.deepStrictEqual(sortLists(testData, [[[2]], [[6]]]), result);
      });
    });
  });

  describe("part 1", () => {
    it("sums the correct indices", () => {
      assert.strictEqual(sumOfIndicesOfCorrectlyOrderedLists(testData), 13);
    });
  });

  describe("part 2", () => {
    it("finds the decoder key", () => {
      assert.strictEqual(decoderKey(testData, [[2]], [[6]]), 140);
    });
  });
});
