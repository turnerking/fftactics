require 'spec_helper'

describe CharacterJobsController do
  
  describe "update" do
    before :each do
      @character_job = mock_model(CharacterJob, :id => 13, :job_level => 2)
      CharacterJob.stub!(:find).with("13").and_return(@character_job)
    end
    
    describe "on successful update" do
      it "returns to json to output when updated" do
        opened_job1 = mock_model(CharacterJob, :id => 14, :job_level => 1)
        opened_job1.stub!(:percent_mastery).and_return(10)
        opened_job2 = mock_model(CharacterJob, :id => 15, :job_level => 1)
        opened_job2.stub!(:percent_mastery).and_return(0)
        
        @character_job.stub!(:update_attributes).and_return(true)
        @character_job.stub!(:opened_up_jobs).and_return([opened_job1, opened_job2])
        
        xhr :put, :update, :id => 13, :character_job => { :job_level => 4 }
        
        response.body.should == {"#character_job_14" => {"input" => "<input id=\"character_job_14_job_level\" class=\"job_level\" type=\"text\" value=\"1\" name=\"character_job[14][job_level]\"/>", "class" => "mastery10"}, 
                                 "#character_job_15" => {"input" => "<input id=\"character_job_15_job_level\" class=\"job_level\" type=\"text\" value=\"1\" name=\"character_job[15][job_level]\"/>", "class" => "mastery0"}}.to_json
      end     
    end

    
    it "returns false when update fails" do
      @character_job.stub!(:update_attributes).and_return(false)
      xhr :put, :update, :id => 13, :character_job => { :job_level => 4 }
      response.body.should == "false"
    end
  end
  
end