import { loadData, sum } from "../utils.js";

export async function day4() {
  const day4data = await loadData(4);
  const grid = parse(day4data);
  return `
  --- Day 4: Ceres Search ---
  Number of XMAS words found: ${wordSearch(grid)}
  Number of X-MAS patterns found: ${xMasSearch(grid)}
  `;
}

function parse(input) {
  return input.split("\n").map((line) => line.split(""));
}

function wordSearch(grid) {
  const tests = [];
  for (let row = 0; row < grid.length; row++) {
    for (let col = 0; col < grid[row].length; col++) {
      if (grid[row][col] === "X") {
        // vertical up
        tests.push(
          [
            grid[row][col],
            grid[row][col - 1],
            grid[row][col - 2],
            grid[row][col - 3],
          ].join("")
        );
        // vertical down
        tests.push(
          [
            grid[row][col],
            grid[row][col + 1],
            grid[row][col + 2],
            grid[row][col + 3],
          ].join("")
        );
        // horizontal left
        try {
          tests.push(
            [
              grid[row][col],
              grid[row - 1][col],
              grid[row - 2][col],
              grid[row - 3][col],
            ].join("")
          );
        } catch {}
        // horizontal right
        try {
          tests.push(
            [
              grid[row][col],
              grid[row + 1][col],
              grid[row + 2][col],
              grid[row + 3][col],
            ].join("")
          );
        } catch {}
        // diag ne
        try {
          tests.push(
            [
              grid[row][col],
              grid[row + 1][col - 1],
              grid[row + 2][col - 2],
              grid[row + 3][col - 3],
            ].join("")
          );
        } catch {}
        // diag se
        try {
          tests.push(
            [
              grid[row][col],
              grid[row + 1][col + 1],
              grid[row + 2][col + 2],
              grid[row + 3][col + 3],
            ].join("")
          );
        } catch {}
        // diag sw
        try {
          tests.push(
            [
              grid[row][col],
              grid[row - 1][col + 1],
              grid[row - 2][col + 2],
              grid[row - 3][col + 3],
            ].join("")
          );
        } catch {}
        // diag nw
        try {
          tests.push(
            [
              grid[row][col],
              grid[row - 1][col - 1],
              grid[row - 2][col - 2],
              grid[row - 3][col - 3],
            ].join("")
          );
        } catch {}
      }
    }
  }
  return tests.filter((test) => test === "XMAS").length;
}

function xMasSearch(grid) {
  let count = 0;
  for (let row = 0; row < grid.length; row++) {
    for (let col = 0; col < grid[row].length; col++) {
      if (grid[row][col] === "A") {
        try {
          if (
            (grid[row - 1][col - 1] === "M" &&
              grid[row - 1][col + 1] === "S" &&
              grid[row + 1][col - 1] === "M" &&
              grid[row + 1][col + 1] === "S") ||
            (grid[row - 1][col - 1] === "S" &&
              grid[row - 1][col + 1] === "M" &&
              grid[row + 1][col - 1] === "S" &&
              grid[row + 1][col + 1] === "M") ||
            (grid[row - 1][col - 1] === "M" &&
              grid[row - 1][col + 1] === "M" &&
              grid[row + 1][col - 1] === "S" &&
              grid[row + 1][col + 1] === "S") ||
            (grid[row - 1][col - 1] === "S" &&
              grid[row - 1][col + 1] === "S" &&
              grid[row + 1][col - 1] === "M" &&
              grid[row + 1][col + 1] === "M")
          ) {
            count++;
          }
        } catch {}
      }
    }
  }
  return count;
}
