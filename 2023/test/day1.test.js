import { describe, it } from "node:test";
import { strict as assert } from "node:assert";
import {
  extractDigits,
  calibration,
  extractDigitsAndNumbers,
} from "../days/day1.js";

describe("part 1", () => {
  const testData = `1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet`;

  it("extracts the digits from a string into an array", () => {
    const results = [["1", "2"], ["3", "8"], ["1", "2", "3", "4", "5"], ["7"]];
    testData.split("\n").forEach((line, index) => {
      assert.deepEqual(extractDigits(line), results[index]);
    });
  });

  it("combines the first and last digits into a number and sums them all", () => {
    assert.equal(calibration(testData, extractDigits), 142);
  });
});

describe("part 2", () => {
  const testData = `two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen`;

  it("extracts the digits and number words from a string into an array", () => {
    const results = [
      ["2", "1", "9"],
      ["8", "2", "3"],
      ["1", "2", "3"],
      ["2", "1", "3", "4"],
      ["4", "9", "8", "7", "2"],
      ["1", "8", "2", "3", "4"],
      ["7", "6"],
    ];
    testData.split("\n").forEach((line, index) => {
      assert.deepEqual(extractDigitsAndNumbers(line), results[index]);
    });
  });

  it("combines the first and last digits into a number and sums them all", () => {
    assert.equal(calibration(testData, extractDigitsAndNumbers), 281);
  });
});
