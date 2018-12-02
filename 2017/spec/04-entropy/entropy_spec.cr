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

describe "AnagramPassphrase" do
  describe "is_valid?" do
    it "says 'abcde fghij' is a valid passphrase" do
      passphrase = AnagramPassphrase.new("abcde fghij")
      passphrase.is_valid?.should be_true
    end
    it "says 'abcde xyz ecdab' is not a valid passphrase" do # the letters from the third word can be rearranged to form the first word.
      passphrase = AnagramPassphrase.new("abcde xyz ecdab")
      passphrase.is_valid?.should be_false
    end
    it "says 'a ab abc abd abf abj' is a valid passphrase" do # all letters need to be used when forming another word.
      passphrase = AnagramPassphrase.new("a ab abc abd abf abj")
      passphrase.is_valid?.should be_true
    end
    it "says 'iiii oiii ooii oooi oooo' is a valid passphrase" do
      passphrase = AnagramPassphrase.new("iiii oiii ooii oooi oooo")
      passphrase.is_valid?.should be_true
    end
    it "says 'oiii ioii iioi iiio' is not a valid passphrase" do # any of these words can be rearranged to form any other word.
      passphrase = AnagramPassphrase.new("oiii ioii iioi iiio")
      passphrase.is_valid?.should be_false
    end
  end
end
