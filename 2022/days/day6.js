import { loadData } from "../utils.js";

export async function day6() {
  const data = await loadData(6);
  return `
    --- Day 6: Tuning Trouble ---
    First start of packet detected at: ${startOfPacketMarker(data)}
    First start of message detected at: ${startOfMessageMarker(data)}
  `;
}

export function startOfPacketMarker(data) {
  return startMarker(data, 4);
}

export function startOfMessageMarker(data) {
  return startMarker(data, 14);
}

function startMarker(data, numberOfUniques) {
  let pointer = 0;
  let buffer = [];
  while (pointer < numberOfUniques) {
    buffer.push(data[pointer]);
    pointer += 1;
  }
  while (duplicates(buffer) && pointer < data.length) {
    buffer.shift();
    buffer.push(data[pointer]);
    pointer += 1;
  }
  return pointer;
}

function duplicates(array) {
  const set = new Set(array);
  return set.size !== array.length;
}
