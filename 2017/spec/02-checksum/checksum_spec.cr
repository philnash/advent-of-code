require "spec"
require "../../02-checksum/checksum"

describe "Checksum" do
  describe "#row_value" do
    it "returns 8 for the input 5 1 9 5" do
      Checksum.row_value("5	1 9 5").should eq(8)
    end
    it "returns 4 for the input 7 5 3" do
      Checksum.row_value("7 5 3").should eq(4)
    end
    it "returns 6 for the input 2 4 6 8" do
      Checksum.row_value("2 4 6 8").should eq(6)
    end
  end
  describe "#calculate" do
    spreadsheet = "5 1 9 5\n" \
                  "7 5 3\n" \
                  "2 4 6 8"
    it "returns 18 for spreadsheet" do
      Checksum.calculate(spreadsheet).should eq(18)
    end
  end
end

describe "Checksum2" do
  describe "#row_value" do
    it "returns 4 from 5 9 2 8" do
      Checksum2.row_value("5 9 2 8").should eq(4)
    end
    it "returns 3 from 9 4 7 3" do
      Checksum2.row_value("9 4 7 3").should eq(3)
    end
    it "returns 2 from 3 8 6 5" do
      Checksum2.row_value("3 8 6 5").should eq(2)
    end
  end

  describe "#calculate" do
    spreadsheet = "5 9 2 8\n" \
                  "9 4 7 3\n" \
                  "3 8 6 5"
    it "returns 18 for spreadsheet" do
      Checksum2.calculate(spreadsheet).should eq(9)
    end
  end
end