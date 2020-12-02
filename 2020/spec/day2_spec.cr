require "spec"
require "../days/day2.cr"

input = ["1-3 a: abcde",
         "1-3 b: cdefg",
         "2-9 c: ccccccccc"]

describe "Passwords" do
  it "recognises valid sled passwords" do
    password = "abcde"
    policy = SledPolicy.new(1, 3, 'c')
    policy.valid?(password).should be_true
    password = "ccccccccc"
    policy = SledPolicy.new(2, 9, 'c')
    policy.valid?(password).should be_true
  end

  it "recognises invalid sled passwords" do
    password = "cdefg"
    policy = SledPolicy.new(1, 3, 'b')
    policy.valid?(password).should be_false
  end

  it "recognises valid toboggan passwords" do
    password = "abcde"
    policy = TobogganPolicy.new(1, 3, 'a')
    policy.valid?(password).should be_true
  end

  it "recognises invalid toboggan passwords" do
    password = "cdefg"
    policy = TobogganPolicy.new(1, 3, 'b')
    policy.valid?(password).should be_false
    password = "ccccccccc"
    policy = TobogganPolicy.new(2, 9, 'c')
    policy.valid?(password).should be_false
  end

  it "should count valid sled passwords" do
    Passwords.check(input, SledPolicy).should eq(2)
  end

  it "should count valid toboggan passwords" do
    Passwords.check(input, TobogganPolicy).should eq(1)
  end
end
