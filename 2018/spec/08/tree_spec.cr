require "spec"
require "../../08/tree.cr"

describe Node do
  it "totals it's metadata without children" do
    node = Node.new(0, 1)
    node.metadata = [1]
    node.metadata_total.should eq(1)
  end

  it "totals it's metadata with children" do
    node = Node.new(1, 2)
    node.metadata = [1, 2]
    child = Node.new(0, 2)
    child.metadata = [3, 4]
    node.children.push(child)
    node.metadata_total.should eq(10)
  end

  it "has a value equal to its metadata total if it has no children" do
    node = Node.new(0, 2)
    node.metadata = [1,2]
    node.value.should eq(3)
  end
end

describe Tree do
  it "is built from a text input" do
    input = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
    index, node = Tree.parse(input)
    index.should eq(16)
    node.num_children.should eq(2)
    node.num_metadata.should eq(3)
    node.metadata_total.should eq(138)
    node.value.should eq(66)
  end
end