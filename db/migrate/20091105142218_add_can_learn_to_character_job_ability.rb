class AddCanLearnToCharacterJobAbility < ActiveRecord::Migration
  def self.up
    add_column :character_job_abilities, :can_learn, :boolean
  end

  def self.down
    remove_column :character_job_abilities, :can_learn
  end
end
