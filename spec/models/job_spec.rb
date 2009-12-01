require 'spec_helper'

describe Job do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "raises no errors given valid attributes" do
    Job.new(@valid_attributes).should be_valid
  end
end
