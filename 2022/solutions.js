import { stripIndent } from "common-tags";
import { day1 } from "./days/day1.js";
import { day2 } from "./days/day2.js";
import { day3 } from "./days/day3.js";
import { day4 } from "./days/day4.js";
import { day5 } from "./days/day5.js";
import { day6 } from "./days/day6.js";

Promise.all([day1(), day2(), day3(), day4(), day5(), day6()]).then(
  (results) => {
    console.log(results.map((result) => stripIndent`${result}`).join("\n"));
  }
);
