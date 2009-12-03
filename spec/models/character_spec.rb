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
    
    describe "create with associations" do
      it "calls initial character jobs after creating" do
        @character = Character.new
        Character.stub!(:create!).and_return(@character)
        @character.should_receive(:initial_character_jobs)
        Character.create_with_associations.should == @character
      end
    end
  end
  
  describe "associations" do
    before :each do
      @character = Character.new
    end
    
    it "has many character jobs" do
      @character.should respond_to(:character_jobs)
    end
    
    it "belongs to a game" do
      @character.should respond_to(:game)
    end
  end
  
  describe "initial character jobs" do
    before :each do
      @character = Character.create!(@valid_attributes)
      @base_class = Job.create!(:name => "Base Class")
      @chemist = Job.create!(:name => "Chemist")
      @knight = Job.create!(:name => "Knight")
      @wizard = Job.create!(:name => "Wizard")
      @bard = Job.create!(:name => "Bard")
      @job_array = [@base_class, @chemist, @knight, @wizard, @bard]
      Job.stub!(:male_jobs).and_return(@job_array)
      CharacterJob.stub!(:create_with_abilities).and_return(CharacterJob.new)
    end
    
    it "gets the correct group of jobs based on gender" do
      Job.should_receive(:male_jobs).and_return(@job_array)
      Job.should_not_receive(:female_jobs)
      @character.initial_character_jobs
    end
    
    it "creates character jobs and attaches them to the character" do
      [[@base_class, 1], [@chemist, 1], [@knight, 0], [@wizard, 0], [@bard, 0]].each do |job, level|
        params = {:job => job, :job_level => level}
        CharacterJob.should_receive(:create_with_abilities).with(params).and_return(CharacterJob.new(params))
      end
      @character.initial_character_jobs
      @character.character_jobs.size.should == 5
    end
  end
  
  describe "base class to sym" do
    it "returns the symbolized version of the character's base class" do
      Character.new(:base_class => "Base Class").base_class_to_sym.should == :"base class"
    end
  end
  
  describe "to string" do
    it "returns the character name and level" do
      Character.new(:name => "Foo", :level => 85).to_s.should == "Foo - 85"
    end
  end
end
