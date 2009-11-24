require 'spec_helper'

describe Ability do
  before(:each) do
    @valid_attributes = {
    
    }
  end
  
  describe "validity" do
    it "creates a new instance given valid attributes" do
      Ability.create!(@valid_attributes)
    end
  end
  
  describe "associations" do
    before :each do
      @ability = Ability.create!(@valid_attributes)
    end
  
    it "is associated with a job" do
      @ability.should respond_to(:job)
    end
    
    it "is associated with character_job_abilities" do
      @ability.should respond_to(:character_job_abilities)
    end
  end
end
