import { loadData } from "../utils.js";

export async function day15() {
  const data = await loadData(15);
  const sensorsAndBeacons = parse(data);
  const beacons = sensorsAndBeacons.map(({ beacon }) => beacon);
  const sensors = sensorsAndBeacons.map(({ sensor }) => sensor);
  return `
    --- Day 15: Beacon Exclusion Zone ---
    Spaces without beacons: ${nonBeaconSpaces(2000000, sensors, beacons)}
    Possible beacon tuning frequency: ${tuningFrequency(
      findPerimeterBeacons(sensors, 0, 4000000, 0, 4000000)
    )}
  `;
}

export function parse(data) {
  return data.split("\n").map(parseLine);
}

const LINE_MATCHER =
  /^Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)$/;

function parseLine(line) {
  const match = line.match(LINE_MATCHER);
  const sensor = { x: parseInt(match[1], 10), y: parseInt(match[2], 10) };
  const beacon = { x: parseInt(match[3], 10), y: parseInt(match[4], 10) };
  sensor.distance = manhattanDistance(sensor, beacon);
  return { sensor, beacon };
}

export function nonBeaconSpaces(lineNumber, sensors, beacons, minX, maxX) {
  const beaconStrings = new Set(beacons.map((b) => JSON.stringify(b)));
  const sensorStrings = new Set(
    sensors.map((sensor) => JSON.stringify({ x: sensor.x, y: sensor.y }))
  );
  const calcMinMax = typeof maxX === "undefined";
  if (typeof maxX === "undefined") {
    maxX = -Infinity;
  }
  if (typeof minX === "undefined") {
    minX = Infinity;
  }
  if (calcMinMax) {
    sensors.forEach((sensor) => {
      if (calcMinMax && sensor.distance + sensor.x > maxX) {
        maxX = sensor.distance + sensor.x;
      }
      if (calcMinMax && sensor.x - sensor.distance < minX) {
        minX = sensor.x - sensor.distance;
      }
    });
  }
  let count = 0;
  for (let x = minX; x < maxX; x++) {
    const point = { x, y: lineNumber };
    const stringPoint = JSON.stringify(point);
    if (
      !sensorStrings.has(stringPoint) &&
      !beaconStrings.has(stringPoint) &&
      sensors.some((sensor) => {
        return withinManhattanDistance(sensor.distance, point, sensor);
      })
    ) {
      count++;
    }
  }
  return count;
}

export function findPerimeterBeacons(sensors, minY, maxY, minX, maxX) {
  for (const sensor of sensors) {
    for (let i = 0; i < sensor.distance + 2; i++) {
      const yDistance = sensor.distance - i;
      const minusY = sensor.y - yDistance - 1;
      const minusX = sensor.x - i;
      const plusY = sensor.y + yDistance + 1;
      const plusX = sensor.x + i;
      const possibleBeacons = [
        { x: minusX, y: minusY },
        { x: minusX, y: plusY },
        { x: plusX, y: minusY },
        { x: plusX, y: plusY },
      ]
        .filter(
          (beacon) =>
            beacon.x >= minX &&
            beacon.x <= maxX &&
            beacon.y >= minY &&
            beacon.y <= maxY
        )
        .filter((beacon) => withinAnySensor(sensors, beacon));
      if (possibleBeacons.length > 0) {
        return possibleBeacons[0];
      }
    }
  }
}

function withinAnySensor(sensors, point) {
  return !sensors.some((sensor) =>
    withinManhattanDistance(sensor.distance, point, sensor)
  );
}

export function tuningFrequency(point) {
  return point.x * 4000000 + point.y;
}

function withinManhattanDistance(distance, point, sensor) {
  return manhattanDistance(sensor, point) <= distance;
}

function manhattanDistance(pointA, pointB) {
  return Math.abs(pointA.x - pointB.x) + Math.abs(pointA.y - pointB.y);
}
