import { loadData, sum } from "../utils.js";

export async function day7() {
  const data = await loadData(7);
  const root = parse(data);
  return `
    --- Day 7: No Space Left On Device ---
    Total size of directories under 100000: ${root.sizeOfDirectoriesUnder(
      100000
    )}
    Size of directory to be deleted: ${root.smallestDirectoryToIncreaseSpaceBy(
      70000000,
      30000000
    )}
  `;
}

class Directory {
  constructor(name, parent) {
    this.name = name;
    this.parent = parent;
    this.files = [];
    this.directories = {};
  }

  size() {
    const fileSize = sum(this.files.map((file) => file.size));
    const dirSize = sum(
      Object.values(this.directories).map((dir) => dir.size())
    );
    return fileSize + dirSize;
  }

  directoriesUnder(size) {
    const result = [];
    if (this.size() < size) {
      result.push(this);
    }
    const dirs = Object.values(this.directories).map((dir) =>
      dir.directoriesUnder(size)
    );
    return result.concat(dirs).flat();
  }

  directoriesOver(size) {
    const result = [];
    if (this.size() > size) {
      result.push(this);
    }
    const dirs = Object.values(this.directories).map((dir) =>
      dir.directoriesOver(size)
    );
    return result.concat(dirs).flat();
  }

  sizeOfDirectoriesUnder(size) {
    const dirs = this.directoriesUnder(size);
    return sum(dirs.map((dir) => dir.size()));
  }

  smallestDirectoryToIncreaseSpaceBy(total, spaceNeeded) {
    const totalUsed = this.size();
    const totalUnused = total - totalUsed;
    const minimumToBeDeleted = spaceNeeded - totalUnused;
    const possibleDirectories = this.directoriesOver(minimumToBeDeleted);
    return Math.min(...possibleDirectories.map((dir) => dir.size()));
  }
}

class File {
  constructor(name, size) {
    this.size = size;
    this.name = name;
  }
}

export function parse(data) {
  const lines = data.split("\n");
  lines.shift();
  const root = new Directory("/");
  let currentDirectory = root;
  lines.forEach((line) => {
    if (line.startsWith("$ ")) {
      line = line.replace(/^\$ /, "");
      if (line.startsWith("cd")) {
        line = line.replace(/^cd /, "");
        if (line === "..") {
          currentDirectory = currentDirectory.parent;
        } else {
          currentDirectory = currentDirectory.directories[line];
        }
      } else {
        // ls (I think we can ignore these)
      }
    } else {
      if (line.startsWith("dir")) {
        line = line.replace(/^dir /, "");
        const newDirectory = new Directory(line, currentDirectory);
        currentDirectory.directories[line] = newDirectory;
      } else {
        let [size, name] = line.split(" ");
        size = parseInt(size, 10);
        const newFile = new File(name, size);
        currentDirectory.files.push(newFile);
      }
    }
  });
  return root;
}
