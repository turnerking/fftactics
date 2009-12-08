require 'spec_helper'

describe ApplicationHelper do
  it "returns the css class to be displayed" do
    character_job = mock("character_job")
    character_job.stub!(:percent_mastery).and_return(40)
    helper.get_job_class(character_job).should == "mastery40"
  end
  
  it "returns a string of a job and its requirements" do
    job = mock("job", :name => "Squire")
    req1 = mock("req1", :required_job => mock("job", :name => "Baby"), :required_level => 3)
    req2 = mock("req2", :required_job => mock("job", :name => "Toddler"), :required_level => 4)
    job.stub!(:required => [req1, req2])
    helper.requirements_for(job).should == "Squire requires:\n3 levels of Baby\n4 levels of Toddler\n"
  end
end