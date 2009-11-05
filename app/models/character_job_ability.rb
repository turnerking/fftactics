class CharacterJobAbility < ActiveRecord::Base
  belongs_to :character_job
  belongs_to :ability
end
