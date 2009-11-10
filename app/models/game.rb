class Game < ActiveRecord::Base
  has_many :characters
  
  def main_character
    characters.detect {|character| character.main_character}
  end
end
