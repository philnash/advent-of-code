require "spec"
require "../days/day8"

describe SIF do
  it "decodes into layers" do
    sif = SIF.decode("123456789012", 3, 2)
    sif.layers.first.should eq([1,2,3,4,5,6])
    sif.layers[1].should eq([7,8,9,0,1,2])
  end

  it "prints the image correctly" do
    sif = SIF.decode("0222112222120000", 2, 2)
    sif.image.should eq([[0,1], [1,0]])
  end
end