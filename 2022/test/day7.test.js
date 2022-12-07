import { describe, it } from "node:test";
import assert from "node:assert";
import { parse } from "../days/day7.js";

const testData = `$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k`;

describe("day 7", () => {
  describe("part 1", () => {
    const root = parse(testData);
    it("sums the size of the root directory to 48381165", () => {
      assert.strictEqual(root.size(), 48381165);
    });

    it("returns directories under a certain size", () => {
      assert.deepStrictEqual(
        root.directoriesUnder(100000).map((dir) => dir.name),
        ["a", "e"]
      );
    });
  });

  describe("part 2", () => {
    const root = parse(testData);
    it("finds the smallest directory to delete", () => {
      assert.strictEqual(
        root.smallestDirectoryToIncreaseSpaceBy(70000000, 30000000),
        24933642
      );
    });
  });
});
