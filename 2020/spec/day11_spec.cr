require "spec"
require "../days/day11"

input = "L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL"

one_cycle = "#.##.##.##
#######.##
#.#.#..#..
####.##.##
#.##.##.##
#.#####.##
..#.#.....
##########
#.######.#
#.#####.##"

two_cycles = "#.LL.L#.##
#LLLLLL.L#
L.L.L..L..
#LLL.LL.L#
#.LL.LL.LL
#.LLLL#.##
..L.L.....
#LLLLLLLL#
#.LLLLLL.L
#.#LLLL.##"

stable = "#.#L.L#.##
#LLL#LL.L#
L.#.L..#..
#L##.##.L#
#.#L.LL.LL
#.#L#L#.##
..L.L.....
#L#L##L#L#
#.LLLLLL.L
#.#L#L#.##"

part_2_cycled_twice = "#.LL.LL.L#
#LLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLL#
#.LLLLLL.L
#.LLLLL.L#"

part_2_stable = "#.L#.L#.L#
#LLLLLL.LL
L.L.L..#..
##L#.#L.L#
L.L#.LL.L#
#.LLLL#.LL
..#.L.....
LLL###LLL#
#.LLLLL#.L
#.L#LL#.L#"

describe WaitingSeats do
  it "turns the input into all occupied seats" do
    seats = WaitingSeats.new(input)
    seats.cycle_part_1
    seats.print.should eq(one_cycle)
    seats.cycle_part_1
    seats.print.should eq(two_cycles)
  end

  it "cycles until stability" do
    seats = WaitingSeats.new(input)
    seats.cycle_part_1_until_stable
    seats.print.should eq(stable)
  end

  it "cycles part 2 differently" do
    seats = WaitingSeats.new(input)
    seats.cycle_part_2
    seats.print.should eq(one_cycle)
    seats.cycle_part_2
    seats.print.should eq(part_2_cycled_twice)
  end

  it "cycles part 2 until stability" do
    seats = WaitingSeats.new(input)
    seats.cycle_part_2_until_stable
    seats.print.should eq(part_2_stable)
  end
end
