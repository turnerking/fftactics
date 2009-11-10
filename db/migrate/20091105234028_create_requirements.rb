class CreateRequirements < ActiveRecord::Migration
  def self.up
    create_table :requirements do |t|
      t.integer :derived_job_id
      t.integer :required_job_id
      t.integer :required_level
    end
  end

  def self.down
    drop_table :requirements
  end
end
