import { stripIndent } from "common-tags";
import { day1 } from "./days/day1.js";
import { day2 } from "./days/day2.js";
import { day3 } from "./days/day3.js";
import { day4 } from "./days/day4.js";
import { day5 } from "./days/day5.js";
import { day6 } from "./days/day6.js";
import { day7 } from "./days/day7.js";
import { day8 } from "./days/day8.js";
import { day9 } from "./days/day9.js";
import { day10 } from "./days/day10.js";
import { day11 } from "./days/day11.js";
import { day12 } from "./days/day12.js";

Promise.all([
  day1(),
  day2(),
  day3(),
  day4(),
  day5(),
  day6(),
  day7(),
  day8(),
  day9(),
  day10(),
  day11(),
  day12(),
]).then((results) => {
  console.log(results.map((result) => stripIndent`${result}`).join("\n"));
});
