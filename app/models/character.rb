class Character < ActiveRecord::Base
  has_many :character_jobs
  
  validates_numericality_of :level, :only_integer => true
  validates_numericality_of :experience, :only_integer => true, :allow_nil => true
  validates_numericality_of :brave, :only_integer => true
  validates_numericality_of :faith, :only_integer => true
  
  def self.astrological_signs
    ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagitaraus", "Capricorn", "Aquarius", "Pisces"]
  end
  
  def self.create_with_associations(character_params)
    character = Character.create!(character_params)
    character.initial_character_jobs
    character
  end
  
  def initial_character_jobs
    Job.send(:"#{gender.downcase}_jobs").each do |job|
      initial_level = ["Squire", "Chemist"].include?(job.name) ? 1 : 0
      character_jobs << CharacterJob.create_with_abilities(:job => job, :job_level => initial_level)
    end
  end
  
  def get_character_job_ability(job, ability)
    return nil unless character_jobs.find_by_job_id(job) 
    character_jobs.find_by_job_id(job).character_job_abilities.find_by_ability_id(ability)
  end
  
  def to_s
    "#{name} - #{level}"
  end
end
