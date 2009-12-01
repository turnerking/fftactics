require 'spec_helper'

describe CharacterJobAbility do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    CharacterJobAbility.create!(@valid_attributes)
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
end
