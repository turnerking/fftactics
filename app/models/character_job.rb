class CharacterJob < ActiveRecord::Base
  has_many :character_job_abilities
  belongs_to :character
  belongs_to :job
  
  validates_numericality_of :job_level, :only_integer => true, :less_than_or_equal_to => 8, :greater_than_or_equal_to => 0
  
  BASIC_ABILITIES = ["Accumulate", "Dash", "Throw Stone", "Heal", "Counter Tackle", "Equip Axe", "Monster Skill", "Defend", "Gained JP Up", "Move +1"]
  MAIN_CHARACTER_ABILITIES = ["Wish", "Yell", "Cheer Up", "Scream", "Ultima"]
  ALTERNATE_ABILITIES = {:lose => ["Accumulate", "Dash", "Throw Stone", "Heal"], 
                         :"holy knight" => ["Statis Sword", "Split Punch", "Crush Punch", "Lightning Stab", "Holy Explosion"],
                         :engineer => ["Leg Aim", "Arm Aim", "Seal Evil"]}
  
  def self.create_with_abilities(character_job_params)
    character_job = CharacterJob.create!(character_job_params)
    character_job.initial_character_job_abilities
    character_job
  end
  
  def initial_character_job_abilities
    job.abilities.each do |ability|
      if ability_available?(ability)
        character_job_abilities << CharacterJobAbility.create!(:ability => ability, :completed => false)
      end
    end
  end
  
  def points_attained
    character_job_abilities.map(&:points_attained).inject {|points, needed| points + needed } || 1
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
  
  def has_requirements?
    can_do_job = true
    job.required.each do |requirement|
      req = CharacterJob.find_by_character_id_and_job_id(character_id, requirement.required_job_id)
      can_do_job = can_do_job && (req.job_level >= requirement.required_level)
    end
    can_do_job
  end
  
  def ability_available?(ability)
    return true unless job.name == "Base Class"
    if character.main_character?
      return true if MAIN_CHARACTER_ABILITIES.include?(ability.name)
    end
    if ALTERNATE_ABILITIES[character.base_class.downcase.to_sym]
      return true if ALTERNATE_ABILITIES[character.base_class.downcase.to_sym].include?(ability.name)
      return false if ALTERNATE_ABILITIES[:lose].include?(ability.name)
    end
    if character.base_class == "Squire"
      return true if BASIC_ABILITIES.include?(ability.name)
    end
    return false
  end
end
