class BagCollection
  def self.parse(input_lines)
    collection = new
    input_lines.each do |input|
      match_data = input.match(/^(?<this_bag>[\w\s]+) bags contain (?<other_bags>(?:\d [\w\s]+ bags?,? ?)+)\.$/)
      if match_data
        this_bag = collection.find_or_create(match_data["this_bag"])
        other_bags = match_data["other_bags"].split(", ").map { |bag| {bag.split(" ").first.to_i, bag.gsub(/^\d /, "").gsub(/ bags?$/, "")} }
        other_bags.each do |(count, bag)|
          bag = collection.find_or_create(bag)
          this_bag.add_children(count, bag)
          bag.add_parent(this_bag)
        end
      end
    end
    collection
  end

  getter all : Hash(String, Bag)

  def initialize
    @all = Hash(String, Bag).new
  end

  def add(bag)
    @all[bag.name] = bag
  end

  def find(name)
    @all[name]
  end

  def find_or_create(name)
    @all.fetch(name, nil) || Bag.new(name, self)
  end
end

class Bag
  getter parents : Array(Bag)
  getter children : Array({Int32, Bag})
  getter name : String

  def initialize(@name, collection : BagCollection)
    @parents = Array(Bag).new
    @children = Array({Int32, Bag}).new
    collection.add(self)
  end

  def add_parent(bag)
    @parents << bag
  end

  def add_children(count, bag)
    @children << {count, bag}
  end

  def containers
    results = Set(Bag).new
    bags_to_check = parents
    while !bags_to_check.empty?
      new_bag = bags_to_check.pop
      bags_to_check = bags_to_check + new_bag.parents
      results.add(new_bag)
    end
    results.size
  end

  def all_children
    return 0 if @children.size == 0
    children.map { |(count, child_bag)| count + count*child_bag.all_children }.sum
  end
end
