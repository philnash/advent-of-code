import { loadData, sum } from "../utils.js";

export async function day2() {
  const data = await loadData(2);
  const strategyOneResult = strategyOne(data);
  const strategyTwoResult = strategyTwo(data);
  return `
    --- Day 2: Rock Paper Scissors ---
    Total score with strategy 1 is: ${strategyOneResult}
    Total score with strategy 2 is: ${strategyTwoResult}
  `;
}

const ROCK = "rock";
const PAPER = "paper";
const SCISSORS = "scissors";
const scores = { rock: 1, paper: 2, scissors: 3 };
const winningScore = 6;
const drawScore = 3;
const loseScore = 0;
const playerMapping = { X: ROCK, Y: PAPER, Z: SCISSORS };
const opponentMapping = { A: ROCK, B: PAPER, C: SCISSORS };
const outcomeMapping = { X: loseScore, Y: drawScore, Z: winningScore };

const outcomes = {
  rock: {
    rock: drawScore,
    paper: loseScore,
    scissors: winningScore,
  },
  paper: {
    rock: winningScore,
    paper: drawScore,
    scissors: loseScore,
  },
  scissors: {
    rock: loseScore,
    paper: winningScore,
    scissors: drawScore,
  },
};

const reverseOutcome = {
  rock: {
    X: SCISSORS,
    Y: ROCK,
    Z: PAPER,
  },
  paper: {
    X: ROCK,
    Y: PAPER,
    Z: SCISSORS,
  },
  scissors: {
    X: PAPER,
    Y: SCISSORS,
    Z: ROCK,
  },
};

/**
 *
 * @param {string} strategy
 */
export function strategyOne(strategy) {
  return sum(
    splitInputIntoTurns(strategy).map(
      (turns) =>
        outcomes[playerMapping[turns[1]]][opponentMapping[turns[0]]] +
        scores[playerMapping[turns[1]]]
    )
  );
}

/**
 *
 * @param {string} strategy
 */
export function strategyTwo(strategy) {
  return sum(
    splitInputIntoTurns(strategy).map(
      (turns) =>
        outcomeMapping[turns[1]] +
        scores[reverseOutcome[opponentMapping[turns[0]]][turns[1]]]
    )
  );
}

/**
 *
 * @param {string} strategy
 * @returns string[][]
 */
function splitInputIntoTurns(strategy) {
  return strategy.split("\n").map((row) => row.split(" "));
}
