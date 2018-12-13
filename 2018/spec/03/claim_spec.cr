require "spec"
require "../../03/claim"

describe Claim do
  it "parses from a string" do
    claim = Claim.parse("#1 @ 1,3: 4x5")
    if claim
      claim.id.should eq(1)
      claim.left.should eq(1)
      claim.top.should eq(3)
      claim.width.should eq(4)
      claim.height.should eq(5)
    end
  end

  it "creates square inches for the covering area" do
    claim = Claim.new(1, 1, 3, 4, 5)
    claim.should contain(SquareInch.new(1, 3))
    claim.should contain(SquareInch.new(2, 4))
    claim.should contain(SquareInch.new(4, 7))
    claim.should_not contain(SquareInch.new(5, 7))
  end
end

describe SquareInch do
  it "initializes with two ints" do
    sq = SquareInch.new(1, 2)
    sq.x.should eq(1)
    sq.y.should eq(2)
  end

  it "should be equeal if x and y are equal" do
    a = SquareInch.new(1, 2)
    b = SquareInch.new(2, 1)
    c = SquareInch.new(1, 2)

    a.should_not eq(b)
    a.should eq(c)
    [a, c].uniq.should eq([a])
  end
end

describe ClaimCollection do
  it "should find duplicate square inches" do
    collection = ClaimCollection.new
    claim1 = Claim.new(1, 1, 1, 2, 1)
    claim2 = Claim.new(2, 1, 1, 1, 1)
    collection.add(claim1)
    collection.add(claim2)
    collection.duplicate_square_inches.should eq(Set.new([SquareInch.new(1, 1)]))
  end

  it "should return no intact claims if all square inches overlap" do
    collection = ClaimCollection.new
    claim1 = Claim.new(1, 1, 1, 2, 1)
    claim2 = Claim.new(2, 1, 1, 1, 1)
    collection.add(claim1)
    collection.add(claim2)
    collection.intact_claims.should eq(Set.new([] of Claim))
  end

  it "should find intact claims" do
    collection = ClaimCollection.new
    claim1 = Claim.new(1, 1, 1, 2, 1)
    claim2 = Claim.new(2, 1, 1, 1, 1)
    claim3 = Claim.new(3, 4, 5, 1, 1)
    collection.add(claim1)
    collection.add(claim2)
    collection.add(claim3)
    collection.intact_claims.should eq(Set{claim3})
  end
end