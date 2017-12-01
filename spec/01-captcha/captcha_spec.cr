require "spec"
require "../01-captcha/captcha"

describe "Captcha" do
  describe "#solve" do
    it "returns 3 for input of 1122" do
      Captcha.solve("1122").should eq(3)
    end
    it "returns 4 for input of 1111" do
      Captcha.solve("1111").should eq(4)
    end
    it "returns 0 for input of 1234" do
      Captcha.solve("1234").should eq(0)
    end
    it "returns 0 for input of 91212129" do
      Captcha.solve("91212129").should eq(9)
    end
  end

  describe "#solve with a specified shift" do

    # 1212 produces 6: the list contains 4 items, and all four digits match the digit 2 items ahead.
    # 1221 produces 0, because every comparison is between a 1 and a 2.
    # 123425 produces 4, because both 2s match each other, but no other digit has a match.
    # 123123 produces 12.
    # 12131415 produces 4.

    it "returns 6 for 1212" do
      Captcha.solve_for_halfway("1212").should eq(6)
    end
    it "returns 0 for 1221" do
      Captcha.solve_for_halfway("1221").should eq(0)
    end
    it "returns 4 for 123425" do
      Captcha.solve_for_halfway("123425").should eq(4)
    end
    it "returns 12 for 123123" do
      Captcha.solve_for_halfway("123123").should eq(12)
    end
    it "returns 4 for 12131415" do
      Captcha.solve_for_halfway("12131415").should eq(4)
    end
  end
end