import { readFile } from "node:fs/promises";
import { join } from "node:path";

export async function loadData(day) {
  return await readFile(join("days", `day${day}.txt`), {
    encoding: "utf-8",
  });
}

/**
 *
 * @param {number[]} array
 */
export function sum(array) {
  return array.reduce((acc, curr) => acc + curr, 0);
}
