class Job < ActiveRecord::Base
  has_many :abilities
  has_many :character_jobs
  has_many :required, :foreign_key => 'derived_job_id', :class_name => 'Requirement'
  has_many :derived, :foreign_key => 'required_job_id', :class_name => 'Requirement'
  has_many :required_jobs, :through => :required
  has_many :derived_jobs, :through => :derived
  
  BASE_JOBS = ["Base Class", "Chemist", "Knight", "Archer", "Monk", "Priest", "Wizard", "Time Mage", "Summoner", "Thief", "Mediator", "Oracle", "Geomancer", "Lancer", "Samurai", "Ninja", "Calculator", "Dancer", "Bard", "Mime"]
  
  named_scope :male_jobs, :conditions => "name != 'Dancer'"
  named_scope :female_jobs, :conditions => "name != 'Bard'"
  
  def points_needed_for_mastery
    Ability.sum('cost', :conditions => "job_id = #{id}")
  end
  
end
