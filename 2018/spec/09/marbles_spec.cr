require "spec"
require "../../09/marbles.cr"

describe Game do
  it "returns the high score for 1618, 10" do
    game = Game.new(1618.to_i64, 10)
    game.play.should eq(8317)
  end
  it "returns the high score for 7999, 13" do
    game = Game.new(7999.to_i64, 13)
    game.play.should eq(146373)
  end
  it "returns the high score for 1104, 17" do
    game = Game.new(1104.to_i64, 17)
    game.play.should eq(2764)
  end
  it "returns the high score for 6111, 21" do
    game = Game.new(6111.to_i64, 21)
    game.play.should eq(54718)
  end
  it "returns the high score for 5807, 30" do
    game = Game.new(5807.to_i64, 30)
    game.play.should eq(37305)
  end
end