require "spec"
require "../05-trampolines/trampolines"

input = "0\n3\n0\n1\n-3"

describe "Offsets" do
  describe "Initial offsets" do
    offsets = Offsets.new(input)

    it "should start at the first offset" do
      offsets.pointer.should eq(0)
    end

    it "should not be finished" do
      offsets.finished?.should be_false
    end

    it "should turn the string into an array of offsets" do
      offsets.list.should eq([0, 3, 0, 1, -3])
    end
  end

  describe "after 1 jump" do
    offsets = Offsets.new(input).jump!

    it "should still point at the first item" do
      offsets.pointer.should eq(0)
    end

    it "should not be finished" do
      offsets.finished?.should be_false
    end

    it "should increment previous item by 1" do
      offsets.list.should eq([1, 3, 0, 1, -3])
    end
  end

  describe "after 2 jumps" do
    offsets = Offsets.new(input).jump!.jump!

    it "should point to the second item" do
      offsets.pointer.should eq(1)
    end

    it "should not be finished" do
      offsets.finished?.should be_false
    end

    it "should increment previous item by 1" do
      offsets.list.should eq([2, 3, 0, 1, -3])
    end
  end

  describe "after 3 jumps" do
    offsets = Offsets.new(input).jump!.jump!.jump!

    it "should point at the last item" do
      offsets.pointer.should eq(4)
    end

    it "should not be finished" do
      offsets.finished?.should be_false
    end

    it "should increment previous item by 1" do
      offsets.list.should eq([2, 4, 0, 1, -3])
    end
  end

  describe "after 4 jumps" do
    offsets = Offsets.new(input).jump!.jump!.jump!.jump!

    it "should point at the second item again" do
      offsets.pointer.should eq(1)
    end

    it "should not be finished" do
      offsets.finished?.should be_false
    end

    it "should increment previous item by 1" do
      offsets.list.should eq([2, 4, 0, 1, -2])
    end
  end

  describe "after 5 jumps" do
    offsets = Offsets.new(input).jump!.jump!.jump!.jump!.jump!

    it "should point outside the list" do
      offsets.pointer.should eq(5)
    end

    it "should be finished" do
      offsets.finished?.should be_true
    end

    it "should increment previous item by 1" do
      offsets.list.should eq([2, 5, 0, 1, -2])
    end

    it "should return the count of jumps" do
      offsets.counter.should eq(5)
    end
  end

  it "should count the jumps until escape" do
    Offsets.jumps_until_out(input).should eq(5)
  end
end
