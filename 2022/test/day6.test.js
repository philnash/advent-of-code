import { describe, it } from "node:test";
import assert from "node:assert";
import { startOfMessageMarker, startOfPacketMarker } from "../days/day6.js";

const testDataAndResults = [
  ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7, 19],
  ["bvwbjplbgvbhsrlpgdmjqwftvncz", 5, 23],
  ["nppdvjthqldpwncqszvftbrmjlhg", 6, 23],
  ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10, 29],
  ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11, 26],
];

describe("day 6", () => {
  describe("part 1", () => {
    testDataAndResults.forEach(([testData, expectedResult]) => {
      it(`find the result is ${expectedResult}`, () => {
        assert.strictEqual(startOfPacketMarker(testData), expectedResult);
      });
    });
  });

  describe("part 2", () => {
    testDataAndResults.forEach(([testData, _, expectedResult]) => {
      it(`find the result is ${expectedResult}`, () => {
        assert.strictEqual(startOfMessageMarker(testData), expectedResult);
      });
    });
  });
});
