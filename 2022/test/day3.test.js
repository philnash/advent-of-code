import { describe, it } from "node:test";
import assert from "node:assert";
import {
  compartmentsFromItems,
  itemInBothCompartments,
  itemInThreeBags,
  itemToPriority,
  sumOfBadgePriorities,
  sumOfItemPrioritiesFromBothCompartments,
} from "../days/day3.js";

describe("day 3", () => {
  describe("utilities", () => {
    it("returns the two compartments of items from one string", () => {
      const compartments = compartmentsFromItems("vJrwpWtwJgWrhcsFMMfFFhFp");
      assert.deepStrictEqual(compartments[0], "vJrwpWtwJgWr".split(""));
      assert.deepStrictEqual(compartments[1], "hcsFMMfFFhFp".split(""));
    });

    it("returns the item that exists in both compartments", () => {
      assert.strictEqual(
        itemInBothCompartments([
          "vJrwpWtwJgWr".split(""),
          "hcsFMMfFFhFp".split(""),
        ]),
        "p"
      );
    });

    it("returns the item in all the bags", () => {
      assert.deepStrictEqual(
        itemInThreeBags([
          "vJrwpWtwJgWrhcsFMMfFFhFp".split(""),
          "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL".split(""),
          "PmmdzqPrVvPwwTWBwg".split(""),
        ]),
        "r"
      );
      assert.deepStrictEqual(
        itemInThreeBags([
          "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn".split(""),
          "ttgJtRGJQctTZtZT".split(""),
          "CrZsJsPPZsGzwwsLwLmpwMDw".split(""),
        ]),
        "Z"
      );
    });

    it("returns an item's priority", () => {
      assert.strictEqual(itemToPriority("p"), 16);
      assert.strictEqual(itemToPriority("A"), 27);
    });
  });

  const testData = `vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw`;

  describe("part 1", () => {
    it("sums the priorities of the items", () => {
      assert.strictEqual(
        sumOfItemPrioritiesFromBothCompartments(testData),
        157
      );
    });
  });

  describe("part 2", () => {
    it("sums the priorities of the badges", () => {
      assert.strictEqual(sumOfBadgePriorities(testData), 70);
    });
  });
});
