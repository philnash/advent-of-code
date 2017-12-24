require "spec"
require "../04-entropy/entropy"

describe "Passphrase" do
  describe "is_valid?" do
    it "says 'aa bb cc dd ee' is valid" do
      passphrase = Passphrase.new("aa bb cc dd ee")
      passphrase.is_valid?.should be_true
    end

    it "says 'aa bb cc dd aa' is not valid" do # the word aa appears more than once.
      passphrase = Passphrase.new("aa bb cc dd aa")
      passphrase.is_valid?.should be_false
    end

    it "says 'aa bb cc dd aaa' is valid" do # aa and aaa count as different words.
      passphrase = Passphrase.new("aa bb cc dd aaa")
      passphrase.is_valid?.should be_true
    end
  end

  describe "count_valid_phrases" do
    Passphrase.count_valid_phrases(["aa bb cc dd ee", "aa bb cc dd aa", "aa bb cc dd aaa"]).should eq(2)
  end
end
