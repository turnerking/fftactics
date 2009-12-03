require 'spec_helper'

describe Job do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "raises no errors given valid attributes" do
    Job.new(@valid_attributes).should be_valid
  end
  
  describe "named scope" do
    before :each do
      ["Base Class", "Chemist", "Knight", "Wizard", "Bard", "Dancer"].each do |name|
        Job.create!(:name => name)
      end
    end
    
    it "returns only male jobs" do
      Job.male_jobs.map(&:name).should_not include("Dancer")
    end
    
    it "returns only female jobs" do
      Job.female_jobs.map(&:name).should_not include("Bard")
    end
  end
  
  describe "associations" do
    before :each do
      @job = Job.new
    end
    
    it "has many abilities" do
      @job.should respond_to(:abilities)
    end
    
    it "has many character jobs" do
      @job.should respond_to(:character_jobs)
    end
    
    it "has many required" do
      @job.should respond_to(:required)
    end
    
    it "has many derived" do
      @job.should respond_to(:derived)
    end
    
    it "has many required jobs" do
      @job.should respond_to(:required_jobs)
    end
    
    it "has many derived jobs" do
      @job.should respond_to(:derived_jobs)
    end
  end
  
  describe "points needed for mastery" do
    it "returns the total from abilities" do
      job = Job.create!(:name => "Cool Job")
      job.abilities << Ability.new(:cost => 300) << Ability.new(:cost => 200)
      job.points_needed_for_mastery.should == 500
    end
  end
end
