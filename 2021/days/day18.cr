module SnailFish
  abstract class Number
    property parent : Number | Nil

    abstract def pairs_with_depth(depth : Int32)
    abstract def set_parent(parent : Number)
    abstract def regular_numbers
  end

  class NullNumber < Number
    def pairs_with_depth(depth)
      Array({Number, Int32}).new
    end

    def set_parent(parent : Number)
      @parent = parent
    end

    def regular_numbers
      Array(RegularNumber).new
    end

    def left
      self
    end

    def right
      self
    end

    def reduce
      self
    end

    def explode
      self
    end

    def +(other : SnailFish::Number)
      other
    end

    def magnitude
      0
    end
  end

  class RegularNumber < Number
    property value : Int32

    def initialize(@value)
    end

    def to_s
      @value.to_s
    end

    def left
      nil
    end

    def right
      nil
    end

    def pairs_with_depth(depth = 0)
      Array({Number, Int32}).new
    end

    def regular_numbers
      [self]
    end

    def split
      new_number = PairNumber.new(RegularNumber.new((value/2).floor.to_i), RegularNumber.new((value/2).ceil.to_i))
      old_parent = @parent
      if !old_parent.nil? && old_parent.is_a?(PairNumber)
        if old_parent.left == self
          old_parent.left = new_number
          new_number.set_parent(old_parent)
        else
          old_parent.right = new_number
          new_number.set_parent(old_parent)
        end
      end
    end

    def reduce
      if @value > 9
        split
      end
      self
    end

    def set_parent(parent : Number)
      @parent = parent
    end

    def +(number : RegularNumber)
      @value += number.value
      self
    end

    def +(number : Number)
      self
    end

    def +(other : Nil)
      self
    end

    def explode
      self
    end

    def magnitude
      @value
    end
  end

  class PairNumber < Number
    property left : Number
    property right : Number

    def initialize(@left, @right)
    end

    def +(other : SnailFish::Number)
      new_number = PairNumber.new(self, other)
      self.set_parent(new_number)
      other.set_parent(new_number)
      new_number.reduce
    end

    def +(other : Nil)
      self
    end

    def reduce
      while pairs_with_depth.any? { |(n, d)| d > 3 } || regular_numbers.any? { |n| n.value > 9 }
        to_be_exploded = pairs_with_depth.find { |(n, depth)| depth > 3 }
        if to_be_exploded
          explode(to_be_exploded[0])
        else
          to_be_split = regular_numbers.find { |n| n.value > 9 }
          to_be_split.split if to_be_split
        end
      end
      self
    end

    def explode(number : Number)
      left_index = regular_numbers.index(number.left)
      if left_index && left_index > 0
        left_number = regular_numbers[left_index - 1]?
        left_number + number.left if left_number
      end
      right_index = regular_numbers.index(number.right)
      if right_index
        right_number = regular_numbers[right_index + 1]?
        right_number + number.right if right_number
      end

      new_zero = RegularNumber.new(0)
      old_parent = number.parent
      if old_parent && old_parent.is_a?(PairNumber)
        if old_parent.left == number
          old_parent.left = new_zero
          new_zero.set_parent(old_parent)
        elsif old_parent.right == number
          old_parent.right = new_zero
          new_zero.set_parent(old_parent)
        end
        return self
      elsif old_parent.is_a?(NullNumber)
        return self
      end
      self
    end

    def pairs_with_depth(depth = 0)
      left.pairs_with_depth(depth + 1) + [{self, depth}] + right.pairs_with_depth(depth + 1)
    end

    def regular_numbers
      left.regular_numbers + right.regular_numbers
    end

    def to_s
      "[#{left.to_s}, #{right.to_s}]"
    end

    def set_parent(parent : Number)
      @parent = parent
      @left.set_parent(self)
      @right.set_parent(self)
    end

    def magnitude
      3*@left.magnitude + 2*@right.magnitude
    end
  end

  def self.parse(input : String)
    chars = input.split("")
    stack = Array(Number).new
    chars.each do |char|
      if char.match(/\d/)
        stack.push(RegularNumber.new(char.to_i))
      elsif char == "]"
        right = stack.pop
        left = stack.pop
        new_number = PairNumber.new(left, right)
        stack.push(new_number)
      end
    end
    number = stack.first
    number.set_parent(NullNumber.new)
    number
  end

  def self.sum(numbers : Array(SnailFish::Number))
    numbers.reduce { |acc, number| acc + number }
  end
end
