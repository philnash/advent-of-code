import { describe, it } from "node:test";
import assert from "node:assert";
import {
  parse,
  nonBeaconSpaces,
  findPerimeterBeacons,
  tuningFrequency,
} from "../days/day15.js";

const testData = `Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3`;

const sensorsAndBeacons = parse(testData);
const beacons = sensorsAndBeacons.map(({ beacon }) => beacon);
const sensors = sensorsAndBeacons.map(({ sensor }) => sensor);

describe("day 15", () => {
  describe("part 1", () => {
    it("measures the squares in a line that can't contain beacons", () => {
      assert.strictEqual(nonBeaconSpaces(10, sensors, beacons), 26);
    });
  });

  describe("part 2", () => {
    it("finds the potential beacon", () => {
      const potentialBeacon = findPerimeterBeacons(sensors, 0, 20, 0, 20);
      assert.strictEqual(potentialBeacon?.x, 14);
      assert.strictEqual(potentialBeacon?.y, 11);
    });

    it("calculates the tuning frequency", () => {
      assert.strictEqual(tuningFrequency({ x: 14, y: 11 }), 56000011);
    });
  });
});
