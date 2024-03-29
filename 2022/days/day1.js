import { loadData, sum } from "../utils.js";

export async function day1() {
  const day1data = await loadData(1);
  const mostCalories = elfWithMostCalories(day1data);
  const topThreeMostCalories = topThreeElvesWithMostCalories(day1data);
  return `
    --- Day 1: Calorie Counting ---
    The elf with the most has ${mostCalories} calories.
    The top 3 elves with the most have ${topThreeMostCalories} calories.
  `;
}

export function elfWithMostCalories(calorieData) {
  const caloriesPerElf = dataToCalorieCounts(calorieData);
  return Math.max(...caloriesPerElf);
}

export function topThreeElvesWithMostCalories(calorieData) {
  let caloriesPerElf = dataToCalorieCounts(calorieData).sort((a, b) => b - a);
  return caloriesPerElf[0] + caloriesPerElf[1] + caloriesPerElf[2];
}

/**
 *
 * @param {string} calorieData
 */
function dataToCalorieCounts(calorieData) {
  return calorieData
    .split("\n\n")
    .map((elf) =>
      sum(elf.split("\n").map((calorieCount) => parseInt(calorieCount, 10)))
    );
}
