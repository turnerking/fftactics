class AddIndexesToImproveLoadTime < ActiveRecord::Migration
  def self.up
    add_index :character_job_abilities, :character_job_id
    add_index :character_job_abilities, [:character_job_id, :ability_id], :unique => true
    add_index :character_jobs, [:job_id, :character_id], :unique => true
  end

  def self.down
    remove_index :character_job, :column => [:job_id, :character_id]
    remove_index :character_job_abilities, :column => [:character_job_id, :ability_id]
    remove_index :character_job_abilities, :character_job_id
  end
end
