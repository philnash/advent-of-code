import { loadData, sum } from "../utils.js";

export async function day15() {
  const data = await loadData(15);
  const result = sum(parse(data).map(hash));
  const focusingPower = sumFocusingPower(putLensesInBoxes(parse(data)));
  return `
  --- Day 15: ---
  Sum of the hashes: ${result}
  Total focusing power: ${focusingPower}
  `;
}

function hash(input) {
  return input
    .split("")
    .reduce((acc, char) => ((acc + char.charCodeAt(0)) * 17) % 256, 0);
}

function parse(input) {
  return input.split(",");
}

function putLensesInBoxes(input) {
  const boxes = new Array(256).fill(null).map(() => []);
  return input.reduce((acc, curr) => {
    if (curr.indexOf("=") > -1) {
      const [label, focal] = curr.split("=");
      const box = hash(label);
      const lens = { label, focal: parseInt(focal, 10) };
      const existingLens = acc[box].find((lens) => lens.label === label);
      if (existingLens) {
        existingLens.focal = lens.focal;
      } else {
        acc[box].push(lens);
      }
    } else {
      const [label] = curr.split("-");
      const box = hash(label);
      acc[box] = acc[box].filter((lens) => lens.label !== label);
    }
    return acc;
  }, boxes);
}

function sumFocusingPower(boxes) {
  return sum(
    boxes.map((box, boxIndex) =>
      sum(box.map((lens, index) => (boxIndex + 1) * (index + 1) * lens.focal))
    )
  );
}
