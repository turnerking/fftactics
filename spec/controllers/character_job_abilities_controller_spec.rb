require 'spec_helper'

describe CharacterJobAbilitiesController do
  before :each do
    @character_job = mock("character job", :id => 5)
    @character_job_ability = mock_model(CharacterJobAbility, :id => 34, :character_job_id => 12, :completed? => false, :character_job => @character_job)
    CharacterJobAbility.stub!(:find).with("34").and_return(@character_job_ability)
    @character_job_ability.stub!(:update_attribute)
    @controller.stub!(:get_job_class).and_return("mastery40")
  end
  
  it "sets the character job ability if id params exists" do
    xhr :put, :update, :id => 34
    assigns[:character_job_ability].should == @character_job_ability
  end
  
  describe "update" do
    it "updates the character job ability to completed" do
      @character_job_ability.should_receive(:update_attribute)
      xhr :put, :update, :id => 34
    end
    
    it "returns json containing elements to update" do
      xhr :put, :update, :id => 34
      response.body.should == {:id => "34", 
                               :character_job_element => "#character_job_5",
                               :mastery_class => "mastery40"}.to_json
    end
  end
  
end