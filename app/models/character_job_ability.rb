class CharacterJobAbility < ActiveRecord::Base
  belongs_to :character_job
  belongs_to :ability
  
  def self.find_by_character_job_and_ability(character, job, ability)
    CharacterJobAbility.find(:first, :select => "character_job_abilities.*", :joins => "JOIN character_jobs ON character_job_abilities.character_job_id = character_jobs.id", :conditions => "character_jobs.character_id = #{character.id} AND character_job_abilities.ability_id = #{ability.id}")
  end
  
  def points_needed
    completed? ? 0 : ability.cost
  end
  
  def points_attained
    completed? ? ability.cost : 0
  end
end
