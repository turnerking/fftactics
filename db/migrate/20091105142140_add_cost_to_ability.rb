class AddCostToAbility < ActiveRecord::Migration
  def self.up
    add_column :abilities, :cost, :integer
  end

  def self.down
    remove_column :abilities, :cost
  end
end
