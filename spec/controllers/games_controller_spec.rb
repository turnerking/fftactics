require 'spec_helper'

describe GamesController do
  describe "get index" do
    it "assigns games instance variable" do
      games = mock("games_collection")
      Game.stub!(:all).and_return(games)
      get :index
      assigns[:games].should == games
    end    
  end

  
  describe "get show" do
    it "assigns game instance variable" do
      game = mock_model(Game, :id => 3)
      Game.stub!(:find).with("3").and_return(game)
      get :show, :id => 3
      assigns[:game].should == game
    end    
  end

  
  describe "get new" do
    before :each do
      @main_character = mock_model(Character)
    end
    
    it "initializes a new Character" do
      Character.should_receive(:new).with({:main_character => true, :name => "Ramza", :gender => "Male"})
      get :new
    end
    
    it "assigns new Character to main_character" do
      Character.stub!(:new).and_return(@main_character)
      get :new
      assigns[:main_character].should == @main_character
    end
  end
  
  describe "post create" do
    before :each do
      @game = mock_model(Game, :id => 34)
      @character = mock_model(Character)
      @characters = mock("character collection")
      
      Character.stub!(:create_with_associations).with({"name" => "FOO"}).and_return(@character)
      Game.stub!(:create!).and_return(@game)
      @game.stub!(:characters).and_return(@characters)
      @characters.stub!(:<<).with(@character)
    end
    
    it "creates the main character" do
      Character.should_receive(:create_with_associations).with({"name" => "FOO"}).and_return(@character)
      post :create, :character => {"name" => "FOO"}
    end
    
    it "creates the game" do
      Game.should_receive(:create!).and_return(@game)
      post :create, :character => {"name" => "FOO"}
    end
    
    it "adds the main character to the game" do
      @characters.should_receive(:<<).with(@character)
      post :create, :character => {"name" => "FOO"}
    end
    
    it "redirects to show" do
      post :create, :character => {"name" => "FOO"}
      response.should redirect_to(game_path(34))
    end
    
  end
  
end