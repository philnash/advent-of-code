import { loadData, sum, product } from "../utils.js";

export async function day2() {
  const day2data = await loadData(2);
  const games = parse(day2data);
  return `
  --- Day 2: Cube Conundrum ---
  Possible games: ${possibleGames(games, 12, 13, 14)}
  Sum of the power of cubes: ${sum(powerOfCubes(minimumSetOfCubes(games)))}
  `;
}

const COLOURS = ["red", "green", "blue"];

function colourFromRound(round, colour) {
  const match = round.match(new RegExp(`(\\d+) ${colour}`));
  return match ? parseInt(match[1], 10) : 0;
}

function parse(input) {
  return input.split("\n").map((line) =>
    line
      .split(": ")[1]
      .split("; ")
      .map((round) =>
        COLOURS.reduce((acc, colour) => {
          acc[colour] = colourFromRound(round, colour);
          return acc;
        }, {})
      )
  );
}

function possibleGames(rounds, red, green, blue) {
  return sum(
    rounds.map((round, index) =>
      round.every(
        (set) => set.blue <= blue && set.red <= red && set.green <= green
      )
        ? index + 1
        : 0
    )
  );
}

function minimumSetOfCubes(rounds) {
  return rounds.map((round) =>
    round.reduce(
      (acc, set) => {
        COLOURS.forEach((colour) => {
          acc[colour] = Math.max(acc[colour], set[colour]);
        });
        return acc;
      },
      { red: 0, blue: 0, green: 0 }
    )
  );
}

function powerOfCubes(games) {
  return games.map((game) => product(Object.values(game)));
}
