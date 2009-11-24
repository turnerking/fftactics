require 'spec_helper'

describe Character do
  before(:each) do
    @valid_attributes = {
      :level => 3,
      :experience => 99,
      :brave => 50,
      :faith => 50,
      :name => "Ramza",
      :gender => "Male",
    }
  end
  
  describe "validity" do
    
    it "is invalid when level is a non-number" do
      character = Character.new(@valid_attributes.merge(:level => "z"))
      character.should_not be_valid
      character.errors.on(:level).should_not be_nil
    end
    
    it "is invalid when level is a non-integer number" do
      character = Character.new(@valid_attributes.merge(:level => 3.5))
      character.should_not be_valid
      character.errors.on(:level).should_not be_nil
    end
    
    it "is invalid when experience is a non-number" do
      character = Character.new(@valid_attributes.merge(:experience => "z"))
      character.should_not be_valid
      character.errors.on(:experience).should_not be_nil
    end
    
    it "is invalid when experience is a non-integer number" do
      character = Character.new(@valid_attributes.merge(:experience => 3.5))
      character.should_not be_valid
      character.errors.on(:experience).should_not be_nil
    end
    
    it "is valid when experience is nil" do
      character = Character.new(@valid_attributes.merge(:experience => nil))
      character.should be_valid
      character.errors.on(:experience).should be_nil
    end
    
    it "is invalid when brave is a non-number" do
      character = Character.new(@valid_attributes.merge(:brave => "z"))
      character.should_not be_valid
      character.errors.on(:brave).should_not be_nil
    end
    
    it "is invalid when brave is a non-integer number" do
      character = Character.new(@valid_attributes.merge(:brave => 3.5))
      character.should_not be_valid
      character.errors.on(:brave).should_not be_nil
    end
    
    it "is invalid when faith is a non-number" do
      character = Character.new(@valid_attributes.merge(:faith => "z"))
      character.should_not be_valid
      character.errors.on(:faith).should_not be_nil
    end
    
    it "is invalid when faith is a non-integer number" do
      character = Character.new(@valid_attributes.merge(:faith => 3.5))
      character.should_not be_valid
      character.errors.on(:faith).should_not be_nil
    end
    
    it "is invalid when name is not present" do
      character = Character.new(@valid_attributes.merge(:name => nil))
      character.should_not be_valid
      character.errors.on(:name).should_not be_nil
    end
    
    it "is invalid when gender is not Male or Female" do
      character = Character.new(@valid_attributes.merge(:gender => "Other"))
      character.should_not be_valid
      character.errors.on(:gender).should_not be_nil
    end
  
    it "raises no errors given valid attributes" do
      Character.new(@valid_attributes).should be_valid
    end  
  end
  
  describe "class methods" do
    describe "astrological signs" do
      it "returns an instance of an Array" do
        Character.astrological_signs.should be_a(Array)
      end
    end
    
    describe "base classes" do
      it "returns an instance of an Array" do
        Character.base_classes.should be_a(Array)
      end
    end
    
    describe "create with associations" do
      it "creates a character and calls to create character jobs" do
        character = mock("character")
        Character.should_receive(:create!).with({:key => "value"}).and_return(character)
        character.should_receive(:initial_character_jobs)
        Character.create_with_associations({:key => "value"}).should == character
      end
    end
    
    describe "by game" do
      before :each do
        @game = mock("game", :id => 6)
        @character1 = Character.create!(@valid_attributes.merge(:game_id => 6, :name => "A"))
        @character2 = Character.create!(@valid_attributes.merge(:game_id => 6, :name => "B"))
        @character3 = Character.create!(@valid_attributes.merge(:game_id => 7, :name => "C"))
      end
      
      describe "names for" do
        it "returns an array of character names" do
          names = Character.names_for(@game)
          names.should include(@character1.name)
          names.should include(@character2.name)
          names.should_not include(@character3.name)
        end
      end
      
      describe "names and ids for" do
        it "returns an array of hashes of character names and ids" do
          array_of_hashes = Character.names_and_ids_for(@game)
          array_of_hashes.should include({"id" => @character1.id.to_s, "name" => @character1.name})
          array_of_hashes.should include({"id" => @character2.id.to_s, "name" => @character2.name})
          array_of_hashes.should_not include({"id" => @character3.id.to_s, "name" => @character3.name})
        end
      end
      
      describe "levels and ids for" do
        it "returns an array of hashes of character levels and ids" do
          array_of_hashes = Character.levels_and_ids_for(@game)
          array_of_hashes.should include({"id" => @character1.id.to_s, "level" => @character1.level.to_s})
          array_of_hashes.should include({"id" => @character2.id.to_s, "level" => @character2.level.to_s})
          array_of_hashes.should_not include({"id" => @character3.id.to_s, "level" => @character3.level.to_s})
        end
      end
    end
  end
  
  describe "associations" do
    before :each do
      
    end
  end
end
