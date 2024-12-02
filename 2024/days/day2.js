import { loadData } from "../utils.js";

export async function day2() {
  const day2data = await loadData(2);
  const reports = parse(day2data);
  return `
  --- Day 2: Red-Nosed Reports ---
  Safe reports: ${countSafeReports(reports)}
  Safe reports with dampener: ${countSafeDampenedReports(reports)}
  `;
}

function parse(data) {
  return data
    .split("\n")
    .map((line) => line.split(/\s+/).map((num) => parseInt(num, 10)));
}

function isSafe(report) {
  let increasing = report[0] < report[1];
  for (let i = 0; i < report.length - 1; i++) {
    const diff = increasing
      ? report[i + 1] - report[i]
      : report[i] - report[i + 1];
    if (diff > 3 || diff < 1) {
      return false;
    }
  }
  return true;
}

function isSafeWithDampener(report) {
  if (isSafe(report)) {
    return true;
  }
  for (let i = 0; i < report.length; i++) {
    if (isSafe(report.filter((_, index) => index !== i))) {
      return true;
    }
  }
  return false;
}

function countSafeReports(reports) {
  return reports.filter(isSafe).length;
}

function countSafeDampenedReports(reports) {
  return reports.filter(isSafeWithDampener).length;
}
