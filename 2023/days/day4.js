import { loadData, setIntersect, sum } from "../utils.js";

export async function day4() {
  const data = await loadData(4);
  const input = parse(data);
  return `
  --- Day 4: Scratchcards ---
  Total points: ${winningScore(input)}
  Total scratchcards: ${winningScratchcards(input)}
  `;
}

function parse(input) {
  return input.split("\n").map((line, index) => {
    const [winningNumbers, myNumbers] = line
      .split(/:\s+/)[1]
      .split(" | ")
      .map((numberString) =>
        numberString.split(/\s+/).map((str) => parseInt(str, 10))
      );
    return { winningNumbers, myNumbers, count: 1 };
  });
}

function winningScore(parsedCards) {
  return sum(
    parsedCards.map(({ winningNumbers, myNumbers }) => {
      const winners = setIntersect(winningNumbers, myNumbers).length;
      return winners > 0 ? 2 ** (winners - 1) : 0;
    })
  );
}

function winningScratchcards(cards) {
  cards.forEach((card, index) => {
    const winners = setIntersect(card.winningNumbers, card.myNumbers).length;
    for (let i = 1; i <= winners; i++) {
      cards[index + i].count += 1 * card.count;
    }
  });
  return sum(cards.map((card) => card.count));
}
