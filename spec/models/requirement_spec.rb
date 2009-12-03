require 'spec_helper'

describe Requirement do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "raises no errors given valid attributes" do
    Requirement.new(@valid_attributes).should be_valid
  end
  
  describe "associations" do
    before :each do
      @requirement = Requirement.new
    end
    
    it "belongs to a required job" do
      @requirement.should respond_to(:required_job)
    end
    
    it "belongs to a derived job" do
      @requirement.should respond_to(:derived_job)
    end
  end
end
