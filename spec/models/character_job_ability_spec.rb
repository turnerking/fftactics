require 'spec_helper'

describe CharacterJobAbility do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "raises no errors given valid attributes" do
    CharacterJobAbility.new(@valid_attributes).should be_valid
  end
  
  describe "find by character and ability" do
    it "returns the correct character job ability" do
      character = mock("character", :id => 123)
      ability = mock("ability", :id => 12)
      character_job = CharacterJob.create!(:job_level => 0, :character_id => 123)
      character_job_ability = CharacterJobAbility.create!(:character_job => character_job, :ability_id => 12)
      CharacterJobAbility.find_by_character_and_ability(character, ability).should == character_job_ability
    end
  end
  
  describe "points" do
    before :each do
      @ability = Ability.new(:cost => 300)
      @character_job_ability = CharacterJobAbility.new
      @character_job_ability.stub!(:ability).and_return(@ability)
    end
    
    describe "attained" do
      it "returns the cost when completed" do
        @character_job_ability.completed = true
        @character_job_ability.points_attained.should == @ability.cost
      end
      
      it "returns 0 when not completed" do
        @character_job_ability.completed = false
        @character_job_ability.points_attained.should == 0
      end
    end
    
    describe "needed" do
      it "returns 0 when completed" do
        @character_job_ability.completed = true
        @character_job_ability.points_needed.should == 0
      end
      
      it "returns the cost when not completed" do
        @character_job_ability.completed = false
        @character_job_ability.points_needed.should == @ability.cost
      end
    end
  end
  
  describe "associations" do
    before :each do
      @character_job_ability = CharacterJobAbility.new
    end
    
    it "belongs to an ability" do
      @character_job_ability.should respond_to(:ability)
    end
    
    it "belongs to a character job" do
      @character_job_ability.should respond_to(:character_job)
    end
  end
end
