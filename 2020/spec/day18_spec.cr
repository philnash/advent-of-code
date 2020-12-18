require "spec"
require "../days/day18.cr"

describe WrongMaths do
  describe "V1" do
    it "calculates 1 + 2 * 3 + 4 * 5 + 6 to be 71" do
      WrongMaths::V1.calculate("1 + 2 * 3 + 4 * 5 + 6").should eq(71)
    end

    it "calculates 1 + (2 * 3) + (4 * (5 + 6)) to be 51" do
      WrongMaths::V1.calculate("1 + (2 * 3) + (4 * (5 + 6))").should eq(51)
    end

    it "calculates 2 * 3 + (4 * 5) to be 26" do
      WrongMaths::V1.calculate("2 * 3 + (4 * 5)").should eq(26)
    end

    it "calculates 5 + (8 * 3 + 9 + 3 * 4 * 3) to be 437" do
      WrongMaths::V1.calculate("5 + (8 * 3 + 9 + 3 * 4 * 3)").should eq(437)
    end

    it "calculates 5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4)) to be 12240" do
      WrongMaths::V1.calculate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").should eq(12240)
    end
    it "calculates ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2 to be 13632" do
      WrongMaths::V1.calculate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").should eq(13632)
    end
  end

  describe "V2" do
    it "calculates 1 + 2 * 3 + 4 * 5 + 6 to be 71" do
      WrongMaths::V2.calculate("1 + 2 * 3 + 4 * 5 + 6").should eq(231)
    end

    it "calculates 1 + (2 * 3) + (4 * (5 + 6)) to be 51" do
      WrongMaths::V2.calculate("1 + (2 * 3) + (4 * (5 + 6))").should eq(51)
    end

    it "calculates 2 * 3 + (4 * 5) to be 26" do
      WrongMaths::V2.calculate("2 * 3 + (4 * 5)").should eq(46)
    end

    it "calculates 5 + (8 * 3 + 9 + 3 * 4 * 3) to be 437" do
      WrongMaths::V2.calculate("5 + (8 * 3 + 9 + 3 * 4 * 3)").should eq(1445)
    end

    it "calculates 5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4)) to be 12240" do
      WrongMaths::V2.calculate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").should eq(669060)
    end
    it "calculates ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2 to be 13632" do
      WrongMaths::V2.calculate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").should eq(23340)
    end
  end
end
