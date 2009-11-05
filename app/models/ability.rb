class Ability < ActiveRecord::Base
  has_many :character_job_abilities
  belongs_to :job
end
