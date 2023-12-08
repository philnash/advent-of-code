import { loadData } from "../utils.js";

export async function day8() {
  const data = await loadData(8);
  const [dirs, els] = parse(data);
  const startingEls = Object.keys(els).filter((el) => el.endsWith("A"));
  return `
  --- Day 8: Haunted Wasteland ---
  Steps to reach ZZZ: ${followDirections(dirs, els)}
  Steps to reach all nodes ending in Z: ${followDirectionsSimultaneously(
    dirs,
    els,
    startingEls
  )}
  `;
}

function parse(input) {
  let [directions, elements] = input.split(/\n\n/);
  directions = directions.split("");
  elements = elements.split("\n").reduce((graph, line) => {
    const match = line.match(
      /^([A-Z0-9]{3}) = \(([A-Z0-9]{3}), ([A-Z0-9]{3})\)$/
    );
    if (match) {
      graph[match[1]] = { L: match[2], R: match[3] };
    }
    return graph;
  }, {});
  return [directions, elements];
}

function followDirections(directions, elements) {
  let currentElement = "AAA";
  let steps = 0;
  let pointer = 0;
  while (currentElement !== "ZZZ") {
    currentElement = elements[currentElement][directions[pointer]];
    steps++;
    pointer = (pointer + 1) % directions.length;
  }
  return steps;
}

function followDirectionsSimultaneously(
  directions,
  elements,
  startingElements
) {
  let steps = 0;
  let pointer = 0;
  let currentElements = [...startingElements];
  const results = {};
  while (currentElements.length > 0) {
    currentElements = currentElements.map(
      (el) => elements[el][directions[pointer]]
    );
    steps++;
    pointer = (pointer + 1) % directions.length;
    currentElements.forEach((el, index) => {
      if (el.endsWith("Z")) {
        results[startingElements[index]] = steps;
        startingElements.splice(index, 1);
        currentElements.splice(index, 1);
      }
    });
  }
  return leastCommonMultipleAll(Object.values(results));
}

const greatestCommonDivisor = (a, b) =>
  b == 0 ? a : greatestCommonDivisor(b, a % b);
const leastCommonMultiple = (a, b) => (a / greatestCommonDivisor(a, b)) * b;
const leastCommonMultipleAll = (ns) => ns.reduce(leastCommonMultiple, 1);
