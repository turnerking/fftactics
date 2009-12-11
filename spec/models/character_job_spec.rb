require 'spec_helper'

describe CharacterJob do
  before(:each) do
    @valid_attributes = {
      :job_level => 1
    }
  end

  describe "validity" do
    it "is invalid when job level is not an integer between 0 and 8" do
      character_job = CharacterJob.new(:job_level => 9)
      character_job.should_not be_valid
      character_job.errors.on(:job_level).should_not be_nil
    end
    
    it "raises no errors given valid attributes" do
      CharacterJob.new(@valid_attributes).should be_valid
    end    
  end

  
  describe "create with abilities" do
    it "returns the character job" do
      character_job = mock("character_job")
      CharacterJob.stub!(:create!).and_return(character_job)
      character_job.should_receive(:initial_character_job_abilities)
      CharacterJob.create_with_abilities.should == character_job
    end
  end
  
  describe "initial character job abilities" do
    it "attaches character job abilities to the character job" do
      character_job = CharacterJob.new
      job = mock("job")
      heal = mock("heal")
      defend = mock("defend")
      character_job_abilities = mock("collection of abilities")
      character_job.stub!(:job).and_return(job)
      character_job.stub!(:character_job_abilities).and_return(character_job_abilities)
      job.stub!(:abilities).and_return([heal, defend])
      character_job.stub!(:ability_available?).and_return(true)
      
      character_job_abilities.should_receive(:<<).twice
      CharacterJobAbility.should_receive(:create!).twice
      
      character_job.initial_character_job_abilities
    end
  end
  
  describe "opened up jobs" do
    before :each do
      job = Job.create!
      derived_job = Job.create!
      job.derived << Requirement.new(:derived_job_id => derived_job, :required_level => 3)
      @character_job = CharacterJob.create!(@valid_attributes.merge(:job => job))
      @derived_character_job = CharacterJob.create!(:job_level => 0, :job => derived_job)
      
      CharacterJob.stub!(:find_by_character_id_and_job_id).and_return(@derived_character_job)
    end
    
    it "skips a character job when required level has already been achieved" do
      CharacterJob.should_not_receive(:find_by_character_id_and_job_id)
      @character_job.opened_up_jobs(3).should == []
    end
    
    it "returns an empty array when no jobs are opened because requirements have not been reached" do
      @derived_character_job.stub!(:has_requirements?).and_return(false)
      @character_job.opened_up_jobs(1).should == []
    end
    
    it "updates a character job to job level 1 when opened" do
      @character_job.opened_up_jobs(1)
      @derived_character_job.job_level.should == 1
    end
    
    it "returns an array of character_jobs when jobs are opened" do
      @character_job.opened_up_jobs(1).should == [@derived_character_job]
    end
  end
  
  describe "has requirements" do
    before :each do
      job = Job.create!
      required_job = Job.create!
      job.required << Requirement.new(:required_job_id => required_job, :required_level => 2)
      @character_job = CharacterJob.create!(@valid_attributes.merge(:job => job))
    end
    
    it "returns true if character job is open" do
      required_character_job = CharacterJob.create!(:job_level => 3)
      CharacterJob.stub!(:find_by_character_id_and_job_id).and_return(required_character_job)
      @character_job.has_requirements?.should be_true
    end
    
    it "returns false if there is a missing requirement" do
      required_character_job = CharacterJob.create!(:job_level => 1)
      CharacterJob.stub!(:find_by_character_id_and_job_id).and_return(required_character_job)
      @character_job.has_requirements?.should be_false
    end
  end
  
  describe "calculating job points" do
    before :each do
      @job = Job.create!
      @character_job = CharacterJob.create!(@valid_attributes.merge(:job => @job))
      @accumulate = CharacterJobAbility.create!(:ability => Ability.new(:cost => 300, :job => @job), 
                                                :completed => true, :character_job => @character_job)
      @fire = CharacterJobAbility.create!(:ability => Ability.new(:cost => 100, :job => @job), 
                                          :completed => true, :character_job => @character_job)
      @water = CharacterJobAbility.create!(:ability => Ability.new(:cost => 200, :job => @job), 
                                           :completed => true, :character_job => @character_job)
      @wind = CharacterJobAbility.create!(:ability => Ability.new(:cost => 400, :job => @job), 
                                          :completed => true, :character_job => @character_job)
      @earth = CharacterJobAbility.create!(:ability => Ability.new(:cost => 500, :job => @job), 
                                           :completed => false, :character_job => @character_job)
    end
    
    describe "for points attained" do
      it "returns the total" do
        @character_job.points_attained.should == 1000
      end
    
      it "returns 1 when there are no points to cover for jobs with no skills (Mime)" do
        CharacterJob.new.points_attained.should == 1
      end      
    end
    
    describe "for total points for mastery" do
      it "returns the total" do
        @character_job.total_points_for_mastery.should == 1500
      end
    
      it "returns 1 when there are no points to cover for jobs with no skills (Mime)" do
        CharacterJob.create!(@valid_attributes.merge(:job => Job.new)).total_points_for_mastery.should == 1
      end
    end
    
    describe "for percent mastery" do
      it "returns the percent of points earned" do
        @character_job.percent_mastery.should == 66
      end
      
      it "returns the percent of points earned rounded to 10 for display" do
        @character_job.percent_mastery(true).should == 60
      end
    end
    
    describe "for mastered" do
      it "returns true if points attained equals total points" do
        @character_job.stub!(:points_attained).and_return(1500)
        @character_job.mastered?.should be_true
      end
      
      it "returns false if points attained is less than total points" do
        @character_job.mastered?.should be_false
      end
    end
  end
  
  describe "ability_available" do
    before :each do
      @character_job = CharacterJob.new
      @job = mock("job", :name => "Base Class")
      @character = mock("character", :main_character? => false)
      @ability = mock("ability")
      @character_job.stub!(:job).and_return(@job)
      @character_job.stub!(:character).and_return(@character)
    end
    
    it "returns true if the job is not Base Class" do
      @job.stub!(:name).and_return("NOT Base Class")
      @character_job.ability_available?(@ability).should be_true
    end
    
    it "returns true if the character is a main character and the ability is a main character ability" do
      @ability.stub!(:name).and_return("Yell")
      @character.stub!(:main_character?).and_return(true)
      @character_job.ability_available?(@ability).should be_true
    end
    
    it "returns true if the character has an alternate base class and the ability is an alternate ability" do
      @ability.stub!(:name).and_return("Leg Aim")
      @character.stub!(:base_class_to_sym).and_return(:engineer)
      @character_job.ability_available?(@ability).should be_true
    end
    
    it "returns false if the character has an alternate base class and the ability is an base ability" do
      @ability.stub!(:name).and_return("Heal")
      @character.stub!(:base_class_to_sym).and_return(:engineer)
      @character_job.ability_available?(@ability).should be_false
    end
    
    it "returns true if the character is a Squire and the ability is a base ability" do
      @ability.stub!(:name).and_return("Heal")
      @character.stub!(:base_class_to_sym).and_return(:squire)
      @character.stub!(:base_class).and_return("Squire")
      @character_job.ability_available?(@ability).should be_true
    end
    
    it "returns false in all other cases" do
      @ability.stub!(:name).and_return("Leg Aim")
      @character.stub!(:base_class_to_sym).and_return(:squire)
      @character.stub!(:base_class).and_return("Squire")
      @character_job.ability_available?(@ability).should be_false
    end
  end
  
  describe "associations" do
    before :each do
      @character_job = CharacterJob.new
    end
    
    it "has many character job abilities" do
      @character_job.should respond_to(:character_job_abilities)
    end
    
    it "belongs to a job" do
      @character_job.should respond_to(:job)
    end
    
    it "belongs to a character" do
      @character_job.should respond_to(:character)
    end
  end
end
