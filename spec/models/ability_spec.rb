require 'spec_helper'

describe Ability do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Ability.create!(@valid_attributes)
  end
end
