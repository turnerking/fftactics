class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :gender
      t.string :astrological_sign
      t.string :name
      t.integer :level
      t.integer :experience
      t.integer :brave
      t.integer :faith
      t.integer :game_id
      t.boolean :main_character, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
