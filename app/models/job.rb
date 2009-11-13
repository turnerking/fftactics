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
  
  def requirements_to_s
    return_string = "#{name} requires:\n"
    required.each do |req|
      return_string << "#{req.required_level} levels of #{req.required_job.name}\n"
    end
    return_string
  end
  
  def requirements_div
    "<div class=\"dialog\" id=\"job_#{id}\" title=\"Requirements for #{name}\"><p>#{requirements_to_s.gsub("\n", "<br>")}</p></div>"
  end
  
end
