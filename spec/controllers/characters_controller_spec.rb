require 'spec_helper'

describe CharactersController do
  describe "get new" do
    it "assigns a new character to instance variable" do
      character = mock_model(Character, :game_id => 13)
      Character.stub!(:new).and_return(character)
      get :new, :game_id => 13
      assigns[:character].should == character
    end
  end
  
  describe "post create" do
    before :each do
      @character = mock_model(Character, :game_id => 13)
      @game = mock_model(Game, :id => 13)
      Game.stub!(:find).and_return(@game)
      Character.stub!(:create_with_associations).and_return(@character)    
    end
    
    it "assigns a new character to instance variable" do
      post :create, :game_id => 13
      assigns[:character].should == @character
    end
    
    it "redirects after creation" do
      post :create, :game_id => 13
      response.should redirect_to(game_path(@game))
    end
  end
  
  describe "get action" do
    before :each do
      @character = mock_model(Character, :id => 15)
      Character.stub!(:find).with("15").and_return(@character)
    end
    
    describe "show" do
      it "assigns found character to instance variable" do
        get :show, :id => 15
        assigns[:character].should == @character
      end
    end
    
    describe "edit" do
      it "assigns found character to instance variable" do
        get :edit, :id => 15
        assigns[:character].should == @character
      end
    end
  end
  
  describe "put update" do
    before :each do
      @character = mock_model(Character, :id => 19)
      Character.stub!(:find).with("19").and_return(@character)
    end
    
    it "returns true if successful" do
      @character.stub!(:update_attributes).and_return(true)
      xhr :put, :update, :id => 19
      response.body.should == "true"
    end
    
    it "returns false if not successful" do
      @character.stub!(:update_attributes).and_return(false)
      xhr :put, :update, :id => 19
      response.body.should == "false"
    end
  end
end