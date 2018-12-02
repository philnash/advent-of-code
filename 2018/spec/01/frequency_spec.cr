require "spec"
require "../../01/frequency"

describe Device do
  describe "#new" do
    it "initializes with a default frequency of 0" do
      Device.new.frequency.should eq(0)
    end
  end

  describe "a device" do
    it "has its frequency updated with the input +1, -2, +3, +1" do
      device = Device.new
      device.update(["+1", "-2", "+3", "+1"])
      device.frequency.should eq(3)
    end

    it "has its frequency updated with the input +1, +1, +1" do
      device = Device.new
      device.update(["+1", "+1", "+1"])
      device.frequency.should eq(3)
    end

    it "has its frequency updated with the input +1, +1, -2" do
      device = Device.new
      device.update(["+1", "+1", "-2"])
      device.frequency.should eq(0)
    end

    it "has its frequency updated with the input -1, -2, -3" do
      device = Device.new
      device.update(["-1", "-2", "-3"])
      device.frequency.should eq(-6)
    end
  end

  describe "finding a repeating frequency" do
    it "finds the repeat for +1, -2, +3, +1" do
      device = Device.new
      device.find_duplicate(["+1", "-2", "+3", "+1"])
      device.duplicate.should eq(2)
    end

    it "finds the repeat for +1, -1" do
      device = Device.new
      device.find_duplicate(["+1", "-1"])
      device.duplicate.should eq(0)
    end

    it "finds the repeat for +3, +3, +4, -2, -4" do
      device = Device.new
      device.find_duplicate(["+3", "+3", "+4", "-2", "-4"])
      device.duplicate.should eq(10)
    end
    it "finds the repeat for -6, +3, +8, +5, -6" do
      device = Device.new
      device.find_duplicate(["-6", "+3", "+8", "+5", "-6"])
      device.duplicate.should eq(5)
    end
    it "finds the repeat for +7, +7, -2, -7, -4" do
      device = Device.new
      device.find_duplicate(["+7", "+7", "-2", "-7", "-4"])
      device.duplicate.should eq(14)
    end
  end
end