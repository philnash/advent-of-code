require "spec"
require "../../02/checksum"

describe FabricBox do
  it "is initialized with an id" do
    box = FabricBox.new("abc")
    box.id.should eq("abc")
  end

  describe "counting letters" do
    it "knows if its id has exactly 2 or 3 letters in" do
      box = FabricBox.new("abcdef")
      box.has_exactly?(2).should be_false
      box.has_exactly?(3).should be_false

      box2 = FabricBox.new("bababc")
      box2.has_exactly?(2).should be_true
      box2.has_exactly?(3).should be_true

      box3 = FabricBox.new("abbcde")
      box3.has_exactly?(2).should be_true
      box3.has_exactly?(3).should be_false

      box4 = FabricBox.new("abcccd")
      box4.has_exactly?(2).should be_false
      box4.has_exactly?(3).should be_true

      box5 = FabricBox.new("aabcdd")
      box5.has_exactly?(2).should be_true
      box5.has_exactly?(3).should be_false

      box6 = FabricBox.new("abcdee")
      box6.has_exactly?(2).should be_true
      box6.has_exactly?(3).should be_false

      box7 = FabricBox.new("ababab")
      box7.has_exactly?(2).should be_false
      box7.has_exactly?(3).should be_true
    end
  end
end

describe FabricBoxCollection do
  it "initializes with an array of IDs and turns them into an array of fabric boxes" do
    collection = FabricBoxCollection.new(["aa", "ab"])
    collection.boxes.should be_a(Array(FabricBox))
  end

  it "can create a check sum" do
    collection = FabricBoxCollection.new(["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"])
    collection.checksum.should eq(12)
  end
end