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
end