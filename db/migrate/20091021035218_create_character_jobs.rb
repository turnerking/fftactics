class CreateCharacterJobs < ActiveRecord::Migration
  def self.up
    create_table :character_jobs do |t|
      t.integer :character_id
      t.integer :job_id
      t.integer :job_level
      t.timestamps
    end
  end

  def self.down
    drop_table :character_jobs
  end
end
