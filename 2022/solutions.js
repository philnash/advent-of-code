import { stripIndent } from "common-tags";
import { day1 } from "./days/day1.js";

Promise.all([day1()]).then((results) => {
  console.log(results.map((result) => stripIndent`${result}`).join("\n"));
});
