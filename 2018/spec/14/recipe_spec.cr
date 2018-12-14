require "spec"
require "../../14/recipe.cr"

describe Recipe do
  it "can create the next recipes" do
    Recipe.next_recipes([3, 7], 0, 1).should eq({[3, 7, 1, 0], 0, 1})
  end

  it "can create the next recipes and move the elf pointers" do
    Recipe.next_recipes([3, 7, 1, 0], 0, 1).should eq({[3, 7, 1, 0, 1, 0], 4, 3})
  end

  it "will get the next ten after the given number of recipes" do
    Recipe.next_ten("9").should eq("5158916779")
    Recipe.next_ten("5").should eq("0124515891")
    Recipe.next_ten("18").should eq("9251071085")
    Recipe.next_ten("2018").should eq("5941429882")
  end

  it "will find how many recipes to create the pattern" do
    Recipe.how_many_to_score("51589").should eq(9)
    Recipe.how_many_to_score("15891").should eq(10)
    Recipe.how_many_to_score("01245").should eq(5)
    Recipe.how_many_to_score("92510").should eq(18)
    Recipe.how_many_to_score("59414").should eq(2018)
  end
end