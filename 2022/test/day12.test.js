import { describe, it } from "node:test";
import assert from "node:assert";
import {
  findPath,
  findShortestPathFromLowest,
  findSquare,
  nextMoves,
  parse,
} from "../days/day12.js";

const testData = `Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi`;

describe("day 12", () => {
  describe("utils", () => {
    it("finds the start square", () => {
      const heightMap = parse(testData);
      assert.deepStrictEqual(findSquare(heightMap, "S"), { x: 0, y: 0 });
    });

    it("finds the end square", () => {
      const heightMap = parse(testData);
      assert.deepStrictEqual(findSquare(heightMap, "E"), { x: 5, y: 2 });
    });

    it("finds the next possible moves from the start", () => {
      const heightMap = parse(testData);
      assert.deepStrictEqual(
        nextMoves(heightMap, { x: 0, y: 0, distance: 0 }),
        [
          { x: 1, y: 0, distance: 1 },
          { x: 0, y: 1, distance: 1 },
        ]
      );
    });

    it("finds the next possible moves", () => {
      const heightMap = parse(testData);
      assert.deepStrictEqual(
        nextMoves(heightMap, { x: 1, y: 1, distance: 2 }),
        [
          { x: 2, y: 1, distance: 3 },
          { x: 0, y: 1, distance: 3 },
          { x: 1, y: 2, distance: 3 },
          { x: 1, y: 0, distance: 3 },
        ]
      );

      assert.deepStrictEqual(
        nextMoves(heightMap, { x: 5, y: 3, distance: 2 }),
        [
          { x: 6, y: 3, distance: 3 },
          { x: 4, y: 3, distance: 3 },
          { x: 5, y: 4, distance: 3 },
        ]
      );
    });
  });

  describe("part 1", () => {
    it("finds the shortest path", () => {
      const heightMap = parse(testData);
      assert.strictEqual(findPath(heightMap), 31);
    });
  });

  describe("part 2", () => {
    it("finds the shortest path", () => {
      const heightMap = parse(testData);
      assert.strictEqual(findShortestPathFromLowest(heightMap), 29);
    });
  });
});
