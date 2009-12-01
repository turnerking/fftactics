require 'spec_helper'

describe Game do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "raises no errors given valid attributes" do
    Game.new(@valid_attributes).should be_valid
  end
  
  it "has many characters" do
    @game = Game.new
    @game.should respond_to(:characters)
  end
  
  it "finds the main character for the game" do
    @game = Game.new
    @character1 = Character.new
    @character2 = Character.new(:main_character => true)
    @character3 = Character.new
    @game.stub!(:characters).and_return([@character1, @character2, @character3])
    @game.main_character.should == @character2
  end
end
