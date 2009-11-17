class Character < ActiveRecord::Base
  has_many :character_jobs
  belongs_to :game
  
  validates_numericality_of :level, :only_integer => true
  validates_numericality_of :experience, :only_integer => true, :allow_nil => true
  validates_numericality_of :brave, :only_integer => true
  validates_numericality_of :faith, :only_integer => true
  
  def self.astrological_signs
    ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagitaraus", "Capricorn", "Aquarius", "Pisces"]
  end
  
  def self.bases_classes
    ["Squire", "Engineer", "Holy Knight"]
  end
  
  def self.names_for(game)
    self.connection.select_values("SELECT name FROM characters WHERE game_id = #{game.id}")
  end
  
  def self.names_and_ids_for(game)
    self.connection.select_all("SELECT name, id FROM characters WHERE game_id = #{game.id}")
  end
  
  def self.levels_and_ids_for(game)
    self.connection.select_all("SELECT level, id FROM characters WHERE game_id = #{game.id}")
  end
  
  def self.create_with_associations(character_params)
    character = Character.create!(character_params)
    character.initial_character_jobs
    character
  end
  
  def initial_character_jobs
    Job.send(:"#{gender.downcase}_jobs").each do |job|
      initial_level = ["Base Class", "Chemist"].include?(job.name) ? 1 : 0
      character_jobs << CharacterJob.create_with_abilities(:job => job, :job_level => initial_level)
    end
  end
  
  def to_s
    "#{name} - #{level}"
  end
end
