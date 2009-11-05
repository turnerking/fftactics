class CreateCharacterJobAbilities < ActiveRecord::Migration
  def self.up
    create_table :character_job_abilities do |t|
      t.boolean :completed, :default => false
      t.integer :character_job_id
      t.integer :ability_id
      t.timestamps
    end
  end

  def self.down
    drop_table :character_job_abilities
  end
end
