import { readFile } from "node:fs/promises";
import { join } from "node:path";

/**
 *
 * @param {number} day
 * @returns string
 */
export async function loadData(day) {
  return await readFile(join("data", `day${day}.txt`), {
    encoding: "utf-8",
  });
}

/**
 *
 * @param {number[]} array
 * @returns number
 */
export function sum(array) {
  return array.reduce((acc, curr) => acc + curr, 0);
}

/**
 *
 * @param {number[]} array
 * @returns number
 */
export function product(array) {
  return array.reduce((acc, curr) => acc * curr, 1);
}
