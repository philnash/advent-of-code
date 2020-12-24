class CrabCups
  getter cups : Hash(Int32, Int32)
  getter current_cup : Int32
  getter round : Int32

  def initialize(input : String)
    @cups = Hash(Int32, Int32).new do |hash, key|
      hash[key] = key + 1
    end
    starting_cups = input.split("").map(&.to_i)
    starting_cups.each_with_index { |cup, i|
      if i + 1 < starting_cups.size
        @cups[cup] = starting_cups[i + 1]
      else
        @cups[cup] = starting_cups.max + 1
        # @cups[cup] = starting_cups.first
      end
    }
    @cups[1_000_000] = starting_cups.first
    @current_cup = starting_cups.first
    @round = 1
  end

  def play_round
    # puts "-- move #{round} --"
    # puts "cups: #{@cups.join(" ")}"
    # puts "current cup: #{@current_cup}"
    pick_up = Array(Int32).new
    next_cup = @cups[@current_cup]
    3.times { pick_up.push(next_cup); next_cup = @cups[next_cup] }
    # puts pick_up, next_cup
    @cups[current_cup] = next_cup
    # # puts "pick up: #{pick_up.join(" ")}"
    destination = current_cup - 1
    destination = 1_000_000 if destination == 0
    # destination = @cups.values.max if destination == 0
    while pick_up.includes?(destination)
      destination = destination - 1
      destination = 1_000_000 if destination == 0
      # destination = @cups.values.max if destination == 0
    end
    # puts "destination: #{destination}\n"
    insert_before = @cups[destination]
    @cups[destination] = pick_up.first
    @cups[pick_up.last] = insert_before
    @current_cup = @cups[current_cup]
    # puts @cups
    # print_cups
    # destination_index = @cups.index(destination)
    # if destination_index
    #   pick_up.each { |cup| destination_index+=1; @cups.insert(destination_index, cup) }
    # end
    # @current_cup_pointer = @cups.index(current_cup) || @current_cup_pointer
    # @current_cup_pointer = (@current_cup_pointer + 1) % @cups.size
    @round += 1
  end

  def print_cups
    first = current = 1
    while @cups[current] != first
      print "#{@cups[current]} "
      current = @cups[current]
    end
    puts ""
  end
end

# game = CrabCups.new("389125467")
game = CrabCups.new("394618527")
10000000.times do
  game.play_round
end
after_one = game.cups[1]
after_that = game.cups[after_one]
puts "#{after_one} #{after_that}"
puts after_one.to_i64 * after_that
