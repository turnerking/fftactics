require 'spec_helper'

describe Ability do
  before(:each) do
    @valid_attributes = {
    
    }
  end
  
  describe "validity" do
    it "raises no errors given valid attributes" do
      Ability.new(@valid_attributes).should be_valid
    end
  end
  
  describe "associations" do
    before :each do
      @ability = Ability.new
    end
  
    it "is associated with a job" do
      @ability.should respond_to(:job)
    end
    
    it "is associated with character_job_abilities" do
      @ability.should respond_to(:character_job_abilities)
    end
  end
end
