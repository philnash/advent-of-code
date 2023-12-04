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

/**
 *
 * @param {any[]} array1
 * @param {any[]} array2
 * @returns any[]
 */
export function setIntersect(array1, array2) {
  return array1.filter((item) => array2.includes(item));
}
