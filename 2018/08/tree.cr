class Tree
  def self.parse(text)
    data = text.split(" ").map(&.to_i)
    build(data)
  end

  def self.build(data, index=0)
    node = Node.new(data[index], data[index+1])
    index += 2
    while node.children.size < node.num_children
      index, child = build(data, index)
      node.children.push(child)
    end
    node.metadata = data[index...index+node.num_metadata]
    index += node.num_metadata
    { index, node }
  end
end

class Node
  property metadata : Array(Int32)
  property children : Array(Node)
  getter num_children : Int32
  getter num_metadata : Int32

  def initialize(@num_children, @num_metadata)
    @metadata = [] of Int32
    @children = [] of Node
  end

  def metadata_total : Int32
    metadata.sum + children.map  { |c| c.metadata_total.as(Int32) }.sum
  end

  def value
    if num_children == 0
      metadata_total
    else
      metadata.reduce(0) do |acc, metadata_item|
        if (node = children.fetch(metadata_item-1, nil))
          acc += node.value
        end
        acc
      end
    end
  end
end