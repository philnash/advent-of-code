import { loadData } from "../utils.js";

export async function day5() {
  const data = await loadData(5);
  const [seeds, mappings] = parse(data);
  const lowestLocation = Math.min(
    ...seeds.map((seed) => seedToLocation(seed, mappings))
  );

  return `
  --- Day 5: If You Give A Seed A Fertilizer ---
  Lowest location = ${lowestLocation}
  Real lowest locations = ${lowestOfRanges2(seeds, mappings)}
  `;
}

function parse(input) {
  const mapLines = input.split(/\n\s*\n/);
  const seedLine = mapLines.shift();
  const seeds = seedLine
    .split(": ")[1]
    .split(" ")
    .map((c) => parseInt(c, 10));
  const mappings = mapLines
    .map((mapLine) => mapLine.split(" map:\n"))
    .map(([mapName, lines]) => {
      return new Mapping(
        mapName,
        lines
          .split("\n")
          .map((line) => line.split(/\s+/).map((c) => parseInt(c, 10)))
          .map(([destinationStart, sourceStart, length]) => ({
            destinationStart,
            sourceStart,
            length,
          }))
      );
    });

  return [seeds, mappings];
}

class Mapping {
  constructor(name, mappings) {
    this.name = name;
    this.mappings = mappings;
  }

  destinationFor(source) {
    const result = this.mappings.reduce(
      (result, { destinationStart, sourceStart, length }) => {
        if (sourceStart <= source && sourceStart + length > source) {
          return source + (destinationStart - sourceStart);
        }
        return result;
      },
      source
    );
    return result;
  }

  sourceFor(destination) {
    return this.mappings.reduce(
      (result, { destinationStart, sourceStart, length }) => {
        const source = destination + (sourceStart - destinationStart);
        if (sourceStart <= source && sourceStart + length > source) {
          return source;
        }
        return result;
      },
      destination
    );
  }
}

function seedToLocation(seed, mappings) {
  return mappings.reduce(
    (result, mapping) => mapping.destinationFor(result),
    seed
  );
}

function locationToSeed(location, mappings) {
  return mappings.reduce(
    (result, mapping) => mapping.sourceFor(result),
    location
  );
}

// This gets a result on my data in about 7 minutes
function lowestOfRanges(seeds, mappings) {
  let lowestLocation = Infinity;
  for (let i = 0; i < seeds.length; i = i + 2) {
    const start = seeds[i];
    const range = seeds[i + 1];
    for (let j = start; j < start + range; j++) {
      const location = seedToLocation(j, mappings);
      if (location < lowestLocation) {
        lowestLocation = location;
      }
    }
  }
  return lowestLocation;
}

// This counts up from location 0 until it finds a matching seed.
// It takes about 9 seconds on my laptop and data.
function lowestOfRanges2(seeds, mappings) {
  const seedsLength = seeds.length;
  function isASeed(potentialSeed) {
    for (let i = 0; i < seedsLength; i += 2) {
      if (
        potentialSeed >= seeds[i] &&
        potentialSeed < seeds[i] + seeds[i + 1]
      ) {
        return true;
      }
    }
    return false;
  }
  let location = 0;
  mappings = mappings.toReversed();
  let seed = locationToSeed(location, mappings);
  while (!isASeed(seed)) {
    location++;
    seed = locationToSeed(location, mappings);
  }
  return location;
}

// As an optimisation on the above, this checks locations 10,000 places apart
// until it finds a seed, then it works back to find the lowest location that
// has a seed.
// It runs on my data and laptop in about 9ms
function lowestOfRanges3(seeds, mappings) {
  const seedsLength = seeds.length;
  function isASeed(potentialSeed) {
    for (let i = 0; i < seedsLength; i += 2) {
      if (
        potentialSeed >= seeds[i] &&
        potentialSeed < seeds[i] + seeds[i + 1]
      ) {
        return true;
      }
    }
    return false;
  }
  let location = 0;
  mappings = mappings.toReversed();
  let seed = locationToSeed(location, mappings);
  while (!isASeed(seed)) {
    location += 10000;
    seed = locationToSeed(location, mappings);
  }
  location = location - 10000;
  seed = locationToSeed(location, mappings);
  while (!isASeed(seed)) {
    location++;
    seed = locationToSeed(location, mappings);
  }
  return location;
}

async function race() {
  const data = await loadData(5);
  const [seeds, mappings] = parse(data);
  console.time("location to seed");
  console.log(lowestOfRanges2(seeds, mappings));
  console.timeEnd("location to seed");
}
await race();
