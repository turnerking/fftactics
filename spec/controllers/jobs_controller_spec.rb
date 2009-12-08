require 'spec_helper'

describe JobsController do
  describe "get show" do
    it "assigns job to instance variable" do
      job = mock_model(Job, :id => 34)
      Job.stub!(:find).with("34", :include => :abilities).and_return(job)
      get :show, :id => 34
      assigns[:job].should == job
    end
  end
end