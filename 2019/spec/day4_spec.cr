require "spec"
require "../days/day4"

describe "password tests" do
  it "has never decreasing digits" do
    Password.digits_never_decrease?(111111).should eq(true)
    Password.digits_never_decrease?(111123).should eq(true)
    Password.digits_never_decrease?(135679).should eq(true)
    Password.digits_never_decrease?(223450).should eq(false)
  end

  it "must have two digits next to each other" do
    Password.has_double_digits?(111111).should eq(true)
    Password.has_double_digits?(111123).should eq(true)
    Password.has_double_digits?(135679).should eq(false)
    Password.has_double_digits?(223450).should eq(true)
  end

  it "must have at least one set of exactly two digits next to each other" do
    Password.has_exactly_double_digits?(111111).should eq(false)
    Password.has_exactly_double_digits?(112233).should eq(true)
    Password.has_exactly_double_digits?(123444).should eq(false)
    Password.has_exactly_double_digits?(111122).should eq(true)
  end

  it "counts the passwords in a range" do
    Password.count_passwords("111111-111112").should eq(2)
  end
end