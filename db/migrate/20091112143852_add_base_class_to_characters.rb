class AddBaseClassToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :base_class, :string
  end

  def self.down
    remove_column :characters, :base_class
  end
end
