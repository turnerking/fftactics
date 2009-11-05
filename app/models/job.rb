class Job < ActiveRecord::Base
  has_many :abilities
  has_many :character_jobs
  
  BASE_JOBS = ["Squire", "Chemist", "Knight", "Archer", "Monk", "Priest", "Wizard", "Time Mage", "Summoner", "Thief", "Mediator", "Oracle", "Geomancer", "Lancer", "Samurai", "Ninja", "Calculator", "Dancer", "Bard", "Mime"]
end
