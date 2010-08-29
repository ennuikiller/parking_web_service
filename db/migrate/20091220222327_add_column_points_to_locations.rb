class AddColumnPointsToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :points, :integer
  end

  def self.down
    remove_column :locations, :points
  end
end
