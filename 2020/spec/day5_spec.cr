require "spec"
require "../days/day5.cr"

# BFFFBBFRRR: row 70, column 7, seat ID 567.
# FFFBBBFRRR: row 14, column 7, seat ID 119.
# BBFFBBFRLL: row 102, column 4, seat ID 820.

describe BoardingPass do
  describe "BFFFBBFRRR" do
    it "should have the correct row, column and id" do
      bp = BoardingPass.new("BFFFBBFRRR")
      bp.row_number.should eq(70)
      bp.seat_number.should eq(7)
      bp.seat_id.should eq(567)
    end
  end

  describe "FFFBBBFRRR" do
    it "should have the correct row, column and id" do
      bp = BoardingPass.new("FFFBBBFRRR")
      bp.row_number.should eq(14)
      bp.seat_number.should eq(7)
      bp.seat_id.should eq(119)
    end
  end

  describe "BBFFBBFRLL" do
    it "should have the correct row, column and id" do
      bp = BoardingPass.new("BBFFBBFRLL")
      bp.row_number.should eq(102)
      bp.seat_number.should eq(4)
      bp.seat_id.should eq(820)
    end
  end
end

describe Seats do
  it "should return the highest id" do
    Seats.new(["BFFFBBFRRR", "FFFBBBFRRR", "BBFFBBFRLL"]).highest_id.should eq(820)
  end

  it "should return the missing seat" do
    Seats.new(["BFFFBBFRRR", "BFFFBBFRRL", "BFFFBBFRLR", "BFFFBBFLRR"]).missing_seat.should eq(564)
  end
end
