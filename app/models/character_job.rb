class CharacterJob < ActiveRecord::Base
  has_many :character_job_abilities
  belongs_to :job
  
  def mastered?
    false
  end
end
