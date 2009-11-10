class CharacterJobAbility < ActiveRecord::Base
  belongs_to :character_job
  belongs_to :ability
  
  def points_needed
    completed? ? 0 : ability.cost
  end
  
  def points_attained
    completed? ? ability.cost : 0
  end
end
