class CharacterJob < ActiveRecord::Base
  has_many :character_job_abilities
  belongs_to :character
  belongs_to :job
  
  validates_numericality_of :job_level, :only_integer => true, :less_than_or_equal_to => 8, :greater_than_or_equal_to => 0
  
  def self.create_with_abilities(character_job_params)
    character_job = CharacterJob.create!(character_job_params)
    character_job.initial_character_job_abilities
    character_job
  end
  
  def initial_character_job_abilities
    job.abilities.each do |ability|
      character_job_abilities << CharacterJobAbility.create!(:ability => ability, :completed => false, :can_learn => true)
    end
  end
  
  def points_attained
    character_job_abilities.map(&:points_attained).inject {|points, needed| points + needed } || 0
  end
  
  def total_points_for_mastery
    character_job_abilities.map{|ab| ab.ability.cost}.inject{|points, cost| points + cost} || 1
  end
  
  def percent_mastery(rounded_to_ten = nil)
    percentage = points_attained.to_f / total_points_for_mastery.to_f
    if rounded_to_ten
      (percentage * 10).floor * 10
    else
      (percentage * 100).floor
    end
  end
  
  def get_mastery_css_class
    "mastery#{percent_mastery(true)}"
  end
  
  def mastered?
    points_attained == total_points_for_mastery
  end
end
