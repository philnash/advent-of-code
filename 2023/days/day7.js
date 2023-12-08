import { loadData, sum } from "../utils.js";

export async function day7() {
  const data = await loadData(7);
  const hands = parse(data);
  const sortedHands = hands.toSorted(compare()).toReversed();
  const jokerSortedHands = hands
    .toSorted(compare("score2", NEW_CARD_VALUES))
    .toReversed();
  return `
  --- Day 7 : Camel Cards ---
  Total winnings: ${sum(
    sortedHands.map((hand, index) => hand.bid * (index + 1))
  )}
  Total winnings with jokers: ${sum(
    jokerSortedHands.map((hand, index) => hand.bid * (index + 1))
  )}
  `;
}

const CARD_VALUES = {
  A: 14,
  K: 13,
  Q: 12,
  J: 11,
  T: 10,
  9: 9,
  8: 8,
  7: 7,
  6: 6,
  5: 5,
  4: 4,
  3: 3,
  2: 2,
};

const NEW_CARD_VALUES = { ...CARD_VALUES, J: 1 };

function parse(input) {
  return input.split("\n").map((line) => new Hand(...line.split(" ")));
}

function compare(method = "score", cardValues = CARD_VALUES) {
  return (hand, otherHand) => {
    const diff = otherHand[method]() - hand[method]();
    if (diff !== 0) {
      return diff;
    }
    let pointer = 0;
    while (
      cardValues[hand.cards[pointer]] === cardValues[otherHand.cards[pointer]]
    ) {
      pointer++;
    }
    return (
      cardValues[otherHand.cards[pointer]] - cardValues[hand.cards[pointer]]
    );
  };
}

class Hand {
  constructor(cards, bid) {
    this.cards = cards.split("");
    this.bid = parseInt(bid, 10);
  }

  score() {
    const counts = this.cards.reduce((acc, card) => {
      if (acc[card]) {
        acc[card]++;
      } else {
        acc[card] = 1;
      }
      return acc;
    }, {});
    const sortedScores = Object.values(counts).toSorted((a, b) => b - a);
    switch (sortedScores[0]) {
      case 1:
        return 1;
      case 2:
        return sortedScores.length === 3 ? 3 : 2;
      case 3:
        return sortedScores.length === 2 ? 5 : 4;
      case 4:
        return 6;
      case 5:
        return 7;
      default:
        return 0;
    }
  }

  score2() {
    const counts = this.cards
      .filter((c) => c !== "J")
      .reduce((acc, card) => {
        if (acc[card]) {
          acc[card]++;
        } else {
          acc[card] = 1;
        }
        return acc;
      }, {});
    const jokers = this.cards.filter((c) => c === "J").length;
    let sortedScores = Object.values(counts).toSorted((a, b) => b - a);
    if (sortedScores[0]) {
      sortedScores[0] += jokers;
    } else {
      // No cards, so they are all jokers
      sortedScores.push(5);
    }
    switch (sortedScores[0]) {
      case 1:
        return 1;
      case 2:
        return sortedScores.length === 3 ? 3 : 2;
      case 3:
        return sortedScores.length === 2 ? 5 : 4;
      case 4:
        return 6;
      case 5:
        return 7;
      default:
        return 0;
    }
  }
}
